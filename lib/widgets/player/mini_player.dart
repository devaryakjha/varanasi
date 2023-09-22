import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/utils/extensions/theme.dart';
import 'package:varanasi_mobile_app/widgets/animated_overflow_text.dart';
import 'package:varanasi_mobile_app/widgets/play_pause_button.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  late final PageController _pageController;
  PaletteGenerator? _paletteGenerator;
  void _generatePallete(MediaItem mediaItem) {
    context
        .read<ConfigCubit>()
        .generatePalleteGenerator(mediaItem.artUri.toString())
        .then(
      (value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _paletteGenerator = value;
          });
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    final state = context.readMediaPlayerCubit.state;
    if (state.currentMediaItem != null) {
      _generatePallete(state.currentMediaItem!);
    }
    _pageController = PageController(
      initialPage:
          context.readMediaPlayerCubit.state.queueState.queueIndex ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final PaletteColor? selectedColor = _paletteGenerator?.darkVibrantColor ??
        _paletteGenerator?.darkMutedColor ??
        _paletteGenerator?.dominantColor;
    final Color? backgroundColor = selectedColor?.color.withOpacity(1);
    final Color? foregroundColor = selectedColor?.bodyTextColor.withOpacity(1);
    final (media, isPlaying, queueState) = context.select(
      (MediaPlayerCubit cubit) {
        final queueState = cubit.state.queueState;
        final media = queueState.queue.isNotEmpty
            ? queueState.queue[queueState.queueIndex ?? 0]
            : null;
        return (media, cubit.state.isPlaying, cubit.state.queueState);
      },
    );

    if (media == null) {
      return const SizedBox.shrink();
    }

    Widget buildLeading() {
      return Card(
        elevation: 24,
        borderOnForeground: false,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: CachedNetworkImage(
          imageUrl: media.artUri.toString(),
          fit: BoxFit.cover,
        ),
      );
    }

    Widget buildSubtitle() {
      return AnimatedText(
        media.displayDescription ?? '',
        minFontSize: 12,
        maxFontSize: 12,
        maxLines: 1,
        style: context.textTheme.labelMedium?.copyWith(
          color: foregroundColor,
        ),
      );
    }

    Widget buildTitle() {
      return BlocConsumer<MediaPlayerCubit, MediaPlayerState>(
        listener: (context, state) {
          final queueIndex = state.queueState.queueIndex;
          if (queueIndex != null &&
              _pageController.hasClients &&
              _pageController.page!.round() != queueIndex) {
            _pageController.jumpToPage(queueIndex);
          }
          _generatePallete(state.currentMediaItem!);
        },
        buildWhen: (previous, current) {
          return previous.queueState.queueIndex !=
                  current.queueState.queueIndex ||
              previous.currentMediaItem != current.currentMediaItem;
        },
        builder: (context, state) {
          return SizedBox(
            height: 40,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification.depth == 0 &&
                    notification is ScrollUpdateNotification) {
                  final PageMetrics metrics =
                      notification.metrics as PageMetrics;
                  final int currentPage = metrics.page!.round();
                  if (currentPage != state.queueState.queueIndex) {
                    context.readMediaPlayerCubit.skipToIndex(currentPage);
                  }
                }
                return false;
              },
              child: PageView.builder(
                controller: _pageController,
                itemCount: queueState.queue.length,
                itemBuilder: (context, index) {
                  final media = queueState.queue[index];
                  final title = media.displayTitle ?? '';
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        child: AnimatedText(
                          title,
                          key: ValueKey(media.id),
                          minFontSize: 12,
                          maxFontSize: 12,
                          maxLines: 1,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: foregroundColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.24,
                          ),
                        ),
                      ),
                      Expanded(child: buildSubtitle()),
                    ],
                  );
                },
              ),
            ),
          );
        },
      );
    }

    Widget buildTrailing() {
      return PlayPauseMediaButton(
        foregroundColor: foregroundColor,
        variant: ButtonVariant.iconbutton,
        onPressed: () {
          if (isPlaying) {
            context.read<MediaPlayerCubit>().pause();
            return;
          }
          context.read<MediaPlayerCubit>().play();
        },
        isPlaying: isPlaying,
      );
    }

    return AnimatedContainer(
      key: ValueKey('${media.id}miniplayer'),
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.theme.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8).copyWith(left: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildLeading(),
                const SizedBox(width: 8),
                Expanded(child: buildTitle()),
                buildTrailing(),
              ],
            ),
          ),
          Positioned(
            left: 8,
            right: 8,
            bottom: 0.5,
            child: StreamBuilder(
              stream: AudioService.position,
              builder: (context, snapshot) {
                return LinearProgressIndicator(
                  value: snapshot.hasData
                      ? snapshot.data!.inMilliseconds /
                          media.duration!.inMilliseconds
                      : 0,
                  minHeight: 1.5,
                  color: foregroundColor,
                  backgroundColor: foregroundColor?.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
