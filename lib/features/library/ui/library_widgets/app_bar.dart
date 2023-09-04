import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/utils/constants/constants.dart';
import 'package:varanasi_mobile_app/utils/extensions/router.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';

import 'flexible_space.dart';
import 'sort_by_toggle.dart';

class LibraryAppbar extends StatelessWidget {
  /// {@template library_appbar}
  /// Created an Appbar for the library page
  /// {@endtemplate}
  const LibraryAppbar({super.key, required this.state});

  final LibraryLoaded state;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    return SliverAppBar(
      stretch: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => context.pop(),
      ),
      expandedHeight: kSliverExpandedHeight,
      pinned: kSliverAppBarPinned,
      flexibleSpace: FlexibleSpace(state: state, padding: padding),
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          tooltip: 'Find in playlist',
          icon: const Icon(Icons.search),
          onPressed: () {
            final existingPath = context.routerState.path;
            context.push(
              '$existingPath/${AppRoutes.librarySearch.path}',
              extra:
                  state.sortedMediaItems(context.read<ConfigCubit>().sortType),
            );
          },
        ),
        const SortByToggle(),
      ],
    );
  }
}
