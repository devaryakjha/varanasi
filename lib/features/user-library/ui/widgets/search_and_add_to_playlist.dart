import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/features/library/data/library_repository.dart';
import 'package:varanasi_mobile_app/features/search/cubit/search_cubit.dart';
import 'package:varanasi_mobile_app/features/search/data/search_result/data.dart';
import 'package:varanasi_mobile_app/features/user-library/cubit/user_library_cubit.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/widgets/media_list.dart';

class SearchAndAddToPlaylist extends StatelessWidget {
  final SearchFilter filter;
  final PlayableMedia? media;
  const SearchAndAddToPlaylist(this.filter, {super.key, this.media});

  @override
  Widget build(BuildContext context) {
    if (filter.isAll) {
      return Material(
        child: Navigator(
          onGenerateRoute: (settings) {
            return MaterialPageRoute<void>(
              builder: (context) => const Content(),
            );
          },
        ),
      );
    }
    if (media == null || !(media?.itemType.isAlbum ?? false)) {
      return const Content();
    }
    return AlbumDetailPage(media!);
  }
}

class AlbumDetailPage extends StatelessWidget {
  final PlayableMedia media;
  const AlbumDetailPage(this.media, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: FutureBuilder(
        future: LibraryRepository.instance.fetchLibrary(media),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final mediaItems = snapshot.data?.mediaItems ?? [];
          final state = context.select((LibraryCubit cubit) => cubit.state);
          if (state is! LibraryLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          final selectedPlaylist = state.playlist;
          final (appendItemToLibrary, removeItemFromLibrary) = context.select(
            (UserLibraryCubit cubit) => (
              (Song item) => cubit.appendItemToLibrary(selectedPlaylist, item),
              (Song item) =>
                  cubit.removeItemFromLibrary(selectedPlaylist, item),
            ),
          );
          return MediaListView(
            mediaItems,
            isPlaying: false,
            isItemPlaying: (media) => false,
            trailing: (media) {
              final isAdded = (selectedPlaylist.mediaItems ?? [])
                  .any((item) => item.itemId == media.itemId);
              return IconButton(
                onPressed: () {
                  if (!isAdded) {
                    appendItemToLibrary(media);
                  } else {
                    removeItemFromLibrary(media);
                  }
                },
                icon: isAdded
                    ? const Icon(Icons.check_circle_rounded)
                    : const Icon(Icons.add_circle_outline_rounded),
                iconSize: 30,
              );
            },
          );
        },
      ),
    );
  }
}

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          context.read<SearchCubit>().updateFilter(SearchFilter.all);
        }
      },
      child: Builder(
        builder: (context) {
          final state = context.select((LibraryCubit cubit) => cubit.state);
          if (state is! LibraryLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          final selectedPlaylist = state.playlist;
          final (appendItemToLibrary, removeItemFromLibrary) =
              context.select((UserLibraryCubit cubit) => (
                    (Song item) =>
                        cubit.appendItemToLibrary(selectedPlaylist, item),
                    (Song item) =>
                        cubit.removeItemFromLibrary(selectedPlaylist, item),
                  ));
          final (
            searchResults,
            filter,
            updateFilter,
            query,
            handleScrollUpdate,
            isFetchingMore
          ) = context.select(
            (SearchCubit cubit) => (
              cubit.state.searchResults,
              cubit.state.filter,
              cubit.updateFilter,
              cubit.state.query,
              cubit.handleScrollUpdate,
              cubit.state.isFetchingMore,
            ),
          );
          final emptyResults = searchResults == null;
          final List<PlayableMedia> mediaItems = switch (searchResults) {
            (AllSearchResult allSearchResult) when filter.isAll =>
              allSearchResult.combineMediaItems().toList(),
            (SongSearchResult songSearchResult) when filter.isSongs =>
              songSearchResult.results ?? [],
            (AlbumSearchResult songSearchResult) when filter.isAlbums =>
              songSearchResult.results ?? [],
            _ => [],
          };
          return NotificationListener(
            onNotification: handleScrollUpdate,
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                titleSpacing: 0,
                leading: filter.isAll
                    ? CloseButton(onPressed: () => context.pop())
                    : const BackButton(),
                title: switch (filter) {
                  SearchFilter.all => SearchTitle(controller: _controller),
                  _ => Text("'$query' in ${filter.filter}"),
                },
              ),
              body: Visibility(
                visible: !emptyResults,
                replacement: const EmptySearchResults(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 24),
                      MediaListView(
                        mediaItems,
                        shrinkWrap: true,
                        isPlaying: false,
                        isItemPlaying: (ite) => false,
                        physics: const NeverScrollableScrollPhysics(),
                        onItemTap: (index, media) {
                          if (media.itemType.isAlbum) {
                            Navigator.of(context).push(MaterialPageRoute<void>(
                              builder: (context) => SearchAndAddToPlaylist(
                                  SearchFilter.albums,
                                  media: media),
                            ));
                          }
                        },
                        loading: isFetchingMore,
                        trailing: (media) {
                          if (media.itemType.isAlbum) {
                            return const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                              color: Colors.white,
                            );
                          }
                          final isAdded = (selectedPlaylist.mediaItems ?? [])
                              .any((item) => item.itemId == media.itemId);
                          return IconButton(
                            onPressed: () {
                              if (media is Song) {
                                if (isAdded) {
                                  removeItemFromLibrary(media);
                                } else {
                                  appendItemToLibrary(media);
                                }
                              }
                            },
                            icon: isAdded
                                ? const Icon(Icons.check_circle_rounded)
                                : const Icon(Icons.add_circle_outline_rounded),
                            iconSize: 30,
                          );
                        },
                      ),
                      if (filter.isAll) ...[
                        const Divider(),
                        ...[SearchFilter.songs, SearchFilter.albums].map(
                          (e) => ListTile(
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 24),
                            onTap: () {
                              updateFilter(e);
                              Navigator.of(context)
                                  .push(MaterialPageRoute<void>(
                                builder: (context) => SearchAndAddToPlaylist(e),
                              ));
                            },
                            title: Text(
                              'See all ${e.name}',
                              style: context.textTheme.bodyLarge,
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class EmptySearchResults extends StatelessWidget {
  const EmptySearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Play what you love",
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Search for playlists, songs and more",
            style: context.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SearchTitle extends StatelessWidget {
  const SearchTitle({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: CupertinoSearchTextField(
        controller: _controller,
        backgroundColor: Colors.black87,
        placeholder: "Search",
        itemColor: Colors.white,
        placeholderStyle: const TextStyle(color: Colors.white),
        prefixInsets: const EdgeInsets.symmetric(horizontal: 12),
        itemSize: 24,
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 5.5, 8),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        onSubmitted: context.read<SearchCubit>().triggerSearch,
        autocorrect: false,
        onChanged: context.read<SearchCubit>().triggerSearch,
        onSuffixTap: () {
          context.read<SearchCubit>().clearSearch();
          _controller.clear();
        },
        autofocus: true,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
