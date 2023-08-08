import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/utils/constants/constants.dart';

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
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: state.gradientColors,
          ),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          final imagedimension = constraints.maxWidth / 1.5;
          return FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
            ],
            background: SizedBox(
              height: kSliverExpandedHeight,
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
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
