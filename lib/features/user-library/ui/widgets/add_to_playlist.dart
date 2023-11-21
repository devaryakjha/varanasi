import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/features/user-library/cubit/user_library_cubit.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/app_snackbar.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';
import 'package:varanasi_mobile_app/widgets/animated_overflow_text.dart';
import 'package:varanasi_mobile_app/widgets/media_tile.dart';

class AddToPlaylistPage extends StatefulWidget {
  final String id;
  final String name;
  const AddToPlaylistPage(this.id, {super.key, required this.name});

  @override
  State<AddToPlaylistPage> createState() => _AddToPlaylistPageState();
}

class _AddToPlaylistPageState extends State<AddToPlaylistPage> {
  List<MediaPlaylist> _playlists = [];
  bool showContent = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<UserLibraryCubit>()
          .generateAddToPlaylistSuggestions(widget.name)
          .then((value) {
        _playlists = value;
        setState(() {});
        Timer(const Duration(milliseconds: 250), () {
          showContent = true;
          setState(() {});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedPlaylist = context.select(
      (LibraryCubit cubit) {
        final playlist = cubit.state[widget.id];
        if (playlist is MediaLoadedState) {
          return playlist.playlist;
        }
        return null;
      },
    );
    if (selectedPlaylist == null) {
      return const SizedBox();
    }

    final (
      mediaItems,
      appendItemToLibrary,
      removeItemFromLibrary,
      appendAllItemToLibrary
    ) = context.select((UserLibraryCubit cubit) {
      return (
        cubit.findPlaylist(selectedPlaylist).mediaItems ?? [],
        (Song item) => cubit.appendItemToLibrary(selectedPlaylist, item),
        (Song item) => cubit.removeItemFromLibrary(selectedPlaylist, item),
        (List<Song> item) =>
            cubit.appendAllItemToLibrary(selectedPlaylist, item),
      );
    });
    final textTheme = context.textTheme;
    final color = Colors.grey.shade900;
    final topPadding = context.topPadding;
    final bottomPadding = context.bottomPadding;
    final effectiveHeight =
        context.height - topPadding - kToolbarHeight - bottomPadding;
    final carouselHeight = (effectiveHeight - 45 - 16) * 0.9;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Add to this playlist'),
        titleTextStyle: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.75,
        ),
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      ),
      body: SizedBox(
        width: context.width,
        height: effectiveHeight,
        child: Column(
          children: [
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                fixedSize: Size(context.width * 0.88, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => context.pushNamed(
                AppRoutes.searchAndAddToLibrary.name,
                pathParameters: {"id": widget.id},
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search),
                  const SizedBox(width: 2),
                  Text(
                    'Search',
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.75,
                    ),
                  ),
                ],
              ),
            ),
            if (_playlists.isNotEmpty && showContent)
              CarouselSlider.builder(
                itemCount: _playlists.length,
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  height: carouselHeight,
                  viewportFraction: 0.9,
                ),
                itemBuilder: (context, index, realIndex) {
                  final playlist = _playlists[index];
                  final allAdded = (playlist.mediaItems ?? [])
                      .every((el) => mediaItems.contains(el));
                  return SizedBox(
                    width: context.width,
                    child: Card(
                      color: color,
                      borderOnForeground: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 30,
                                    child: AnimatedText(
                                      playlist.title?.sanitize ?? '',
                                      style: context.textTheme.titleMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                      maxLines: 1,
                                      minFontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  width: 100,
                                  height: 30,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      fixedSize: const Size(100, 24),
                                    ),
                                    onPressed: allAdded
                                        ? null
                                        : () {
                                            final allItems =
                                                playlist.mediaItems ?? [];
                                            final notAddedItems = allItems
                                                .where((el) =>
                                                    !mediaItems.contains(el))
                                                .whereType<Song>()
                                                .toList(growable: false);
                                            appendAllItemToLibrary(
                                                notAddedItems);
                                          },
                                    child: const Text('Add All'),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (ctx, index) {
                                  final item = playlist.mediaItems![index];
                                  final isAdded = mediaItems
                                      .any((el) => el.itemId == item.itemId);
                                  return MediaTile(
                                    item,
                                    index: index,
                                    contentPadding: EdgeInsets.zero,
                                    trailing: IconButton(
                                      onPressed: () {
                                        if (item is Song) {
                                          if (isAdded) {
                                            removeItemFromLibrary(item);
                                          } else {
                                            appendItemToLibrary(item);
                                          }
                                        } else {
                                          AppSnackbar.show('Unsupported');
                                        }
                                      },
                                      icon: isAdded
                                          ? const Icon(
                                              Icons.check_circle_rounded)
                                          : const Icon(
                                              Icons.add_circle_outline_rounded),
                                      iconSize: 30,
                                    ),
                                  );
                                },
                                itemCount: playlist.mediaItems!.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
