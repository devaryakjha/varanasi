import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/utils/constants/constants.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => context.pop(),
      ),
      expandedHeight: kSliverExpandedHeight,
      pinned: kSliverAppBarPinned,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpace(state: state, padding: padding),
      backgroundColor: state.baseColor!.color.dark,
    );
  }
}

class FlexibleSpace extends StatelessWidget {
  const FlexibleSpace({
    super.key,
    required this.state,
    required this.padding,
  });

  final LibraryLoaded state;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final imagedimension = max(constraints.maxHeight / 1.5, 180).toDouble();
      final opacity =
          ((constraints.maxHeight - 200) / 200).clamp(0, 1).toDouble();

      return FlexibleSpaceBar(
        collapseMode: CollapseMode.none,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: state.gradientColors,
            ),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: padding.top + 16),
              Container(
                decoration: BoxDecoration(boxShadow: state.boxShadow),
                child: Image(
                  image: state.image,
                  fit: BoxFit.cover,
                  width: imagedimension,
                  height: imagedimension,
                  opacity: AlwaysStoppedAnimation(opacity),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
