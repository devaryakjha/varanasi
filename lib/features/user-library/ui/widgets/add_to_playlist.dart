import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/features/user-library/cubit/user_library_cubit.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/app_snackbar.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/widgets/media_tile.dart';

class AddToPlaylistPage extends StatefulWidget {
  const AddToPlaylistPage({super.key});

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
          .generateAddToPlaylistSuggestions(
              (context.read<LibraryCubit>().state as LibraryLoaded).playlist)
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
      (LibraryCubit loaded) => (loaded.state as LibraryLoaded).playlist,
    );
    final (mediaItems, appendItemToLibrary) =
        context.select((UserLibraryCubit cubit) {
      return (
        cubit.findPlaylist(selectedPlaylist).mediaItems ?? [],
        (Song item) => cubit.appendItemToLibrary(selectedPlaylist, item)
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
              onPressed: () {},
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
                            Text(
                              playlist.title!,
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
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
                                          appendItemToLibrary(item);
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
