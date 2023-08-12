import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

class FlexibleSpace extends StatelessWidget {
  const FlexibleSpace({
    super.key,
    required this.state,
    required this.padding,
  });

  final LibraryLoaded state;
  final EdgeInsets padding;

  double get toolbarHeight => kToolbarHeight + padding.top;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // calculate the image dimension based on the screen height
      // min the image dimension to 150
      final imagedimension = (constraints.maxHeight - toolbarHeight)
          .clamp(150, constraints.maxWidth)
          .toDouble();

      final opacity = ((constraints.maxHeight - toolbarHeight) / toolbarHeight)
          .clamp(0.0, 1.0);

      final nearlyPinned = opacity <= 0.1;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: state.gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FlexibleSpaceBar(
          collapseMode: CollapseMode.none,
          title: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: nearlyPinned ? 1 : 0,
            child: Text(
              state.title,
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          background: Padding(
            padding: EdgeInsets.only(top: padding.top + 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: imagedimension,
                  width: imagedimension,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: state.image,
                      fit: BoxFit.cover,
                      opacity: opacity,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
