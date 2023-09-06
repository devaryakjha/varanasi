import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/widgets/media_tile.dart';

import 'app_bar.dart';

class LibraryContent extends StatefulWidget {
  const LibraryContent({super.key});

  @override
  State<LibraryContent> createState() => _LibraryContentState();
}

class _LibraryContentState extends State<LibraryContent> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      // check scroll direction
      final direction = _scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.forward) {
        if (_scrollController.offset < 30) {
          context.read<LibraryCubit>().toggleAppbarExpanded(true);
        }
      }
      if (direction == ScrollDirection.reverse) {
        if (_scrollController.offset >= 30) {
          context.read<LibraryCubit>().toggleAppbarExpanded(false);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sortBy = context.select((ConfigCubit cubit) => cubit.sortType);
    final state =
        context.select((LibraryCubit cubit) => cubit.state as LibraryLoaded);
    final sortedMediaItems = state.sortedMediaItems(sortBy);
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          LibraryAppbar(state: state),
          SliverPadding(
            padding: const EdgeInsets.only(top: 24, bottom: 48),
            sliver: SliverList.separated(
              itemCount: state.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final song = sortedMediaItems[index];
                return MediaTile(media: song);
              },
            ),
          ),
        ],
      ),
    );
  }
}
