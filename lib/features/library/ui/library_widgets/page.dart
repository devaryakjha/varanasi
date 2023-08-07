import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/utils/constants/constants.dart';

class PlaylistContent extends StatelessWidget {
  const PlaylistContent({super.key});

  @override
  Widget build(BuildContext context) {
    final state =
        context.select((LibraryCubit cubit) => cubit.state as LibraryLoaded);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: kSliverExpandedHeight,
            pinned: kSliverAppBarPinned,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: state.gradientColors,
                ),
              ),
              child: LayoutBuilder(builder: (context, constraints) {
                return const FlexibleSpaceBar();
              }),
            ),
          )
        ],
      ),
    );
  }
}
