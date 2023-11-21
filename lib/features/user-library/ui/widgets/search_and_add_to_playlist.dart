import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/features/search/cubit/search_cubit.dart';
import 'package:varanasi_mobile_app/features/search/data/search_result/data.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/widgets/media_list.dart';

class SearchAndAddToPlaylist extends StatelessWidget {
  final SearchFilter filter;
  const SearchAndAddToPlaylist(this.filter, {super.key});

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
    return const Content();
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
  void dispose() {
    context.read<SearchCubit>().updateFilter(SearchFilter.all);
    super.dispose();
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
          final (searchResults, filter, updateFilter) = context.select(
            (SearchCubit cubit) => (
              cubit.state.searchResults,
              cubit.state.filter,
              cubit.updateFilter
            ),
          );
          final emptyResults = searchResults == null;
          final List<PlayableMedia> mediaItems = switch (searchResults) {
            (AllSearchResult allSearchResult) =>
              allSearchResult.combineMediaItems(),
            (SongSearchResult songSearchResult) =>
              songSearchResult.results ?? [],
            (AlbumSearchResult songSearchResult) =>
              songSearchResult.results ?? [],
            _ => [],
          };
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              titleSpacing: 0,
              leading: filter.isAll
                  ? CloseButton(onPressed: () => context.pop())
                  : const BackButton(),
              title: SearchTitle(controller: _controller),
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
                      onItemTap: (index, media) {},
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
                            Navigator.of(context).push(MaterialPageRoute<void>(
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
