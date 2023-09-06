import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/features/library/ui/library_widgets/find_in_plyalist.dart';
import 'package:varanasi_mobile_app/features/library/ui/library_widgets/sort_by_toggle.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

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
    final showExtraContent = state.isAppbarExpanded;
    final toolbarHeight =
        kToolbarHeight + padding.top + (showExtraContent ? 32 : 0);
    return LayoutBuilder(builder: (context, constraints) {
      const imagedimension = 250.0;
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
          title: Text(
            state.title,
            style: context.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          background: Padding(
            padding: EdgeInsets.zero.copyWith(top: padding.top),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: showExtraContent ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      height: showExtraContent ? 84 : 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 52),
                            SizedBox(
                              height: 32,
                              child: Row(
                                children: [
                                  Expanded(child: FindInPlyalist(state: state)),
                                  const SizedBox(width: 8),
                                  const SortByToggle(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  height: imagedimension,
                  width: imagedimension,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: state.image,
                      fit: BoxFit.cover,
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
