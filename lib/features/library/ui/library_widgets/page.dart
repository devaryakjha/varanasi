import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/widgets/media_tile.dart';

import 'app_bar.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final state =
        context.select((LibraryCubit cubit) => cubit.state as LibraryLoaded);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          LibraryAppbar(state: state),
          SliverPadding(
            padding: const EdgeInsets.only(top: 24, bottom: 48),
            sliver: SliverList.separated(
              itemCount: state.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final song = state.sortedMediaItems[index];
                return MediaTile(media: song);
              },
            ),
          ),
        ],
      ),
    );
  }
}