import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/search/cubit/search_cubit.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

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
    final searchResults =
        context.select((SearchCubit cubit) => cubit.state.searchResults);
    final emptyResults = searchResults == null;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleSpacing: 0,
        title: SearchTitle(controller: _controller),
      ),
      body: Visibility(
        visible: emptyResults,
        child: const EmptySearchResults(),
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
        onSubmitted: (value) {},
        autocorrect: false,
        onChanged: (value) {},
        onSuffixTap: _controller.clear,
        autofocus: true,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
