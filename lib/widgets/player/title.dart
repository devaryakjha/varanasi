import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/utils/extensions/theme.dart';
import 'package:varanasi_mobile_app/utils/player/typings.dart';
import 'package:varanasi_mobile_app/utils/safe_animate_to_pageview.dart';
import 'package:varanasi_mobile_app/widgets/animated_overflow_text.dart';

class Title extends StatelessWidget {
  const Title({
    super.key,
    required this.queueState,
    required this.colorPalette,
  });

  final QueueState queueState;
  final MediaColorPalette? colorPalette;

  @override
  Widget build(BuildContext context) {
    final (controller, playerController) = context.select((ConfigCubit cubit) {
      if (cubit.state is! ConfigLoaded) return (null, null);
      return (
        (cubit.state as ConfigLoaded).miniPlayerPageController,
        (cubit.state as ConfigLoaded).playerPageController
      );
    });
    return SizedBox(
      height: 40,
      child: CarouselSlider.builder(
        itemCount: queueState.queue.length,
        itemBuilder: (context, index, _) {
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
                    color: colorPalette?.foregroundColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.24,
                  ),
                ),
              ),
              Expanded(
                child: AnimatedText(
                  media.displayDescription ?? '',
                  minFontSize: 12,
                  maxFontSize: 12,
                  maxLines: 1,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: colorPalette?.foregroundColor,
                  ),
                ),
              ),
            ],
          );
        },
        carouselController: controller,
        options: CarouselOptions(
          disableCenter: true,
          initialPage: queueState.queueIndex ?? 0,
          height: 40,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) {
            if (reason == CarouselPageChangedReason.manual) {
              context.read<MediaPlayerCubit>().skipToIndex(index);
              animateToPage(index, playerController);
            }
            if (reason == CarouselPageChangedReason.controller) {
              animateToPage(index, playerController);
            }
          },
        ),
      ),
    );
  }
}
