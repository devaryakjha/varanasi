import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/search/cubit/search_cubit.dart';
import 'package:varanasi_mobile_app/features/search/data/search_result/data.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/widgets/media_list.dart';

class SearchAndAddToPlaylist extends StatefulWidget {
  const SearchAndAddToPlaylist({super.key});

  @override
  State<SearchAndAddToPlaylist> createState() => _SearchAndAddToPlaylistState();
}

class _SearchAndAddToPlaylistState extends State<SearchAndAddToPlaylist> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final (searchResults, updateFilter) = context.select(
      (SearchCubit cubit) => (
        cubit.state.searchResults,
        (SearchFilter filter) => cubit.updateFilter(filter)
      ),
    );
    final emptyResults = searchResults == null;
    final List<PlayableMedia> mediaItems = switch (searchResults) {
      (AllSearchResult allSearchResult) => allSearchResult.combineMediaItems(),
      (SongSearchResult songSearchResult) => songSearchResult.results ?? [],
      (AlbumSearchResult songSearchResult) => songSearchResult.results ?? [],
      _ => [],
    };
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleSpacing: 0,
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
              const Divider(),
              ...[SearchFilter.songs, SearchFilter.albums].map(
                (e) => ListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  onTap: () => updateFilter(e),
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
          ),
        ),
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
