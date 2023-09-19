import 'package:flutter/material.dart' hide Typography;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/features/library/ui/library_widgets/library_app_bar.dart';
import 'package:varanasi_mobile_app/utils/extensions/media_query.dart';
import 'package:varanasi_mobile_app/widgets/media_list.dart';
import 'package:varanasi_mobile_app/widgets/typography.dart';

class LibraryContent extends StatefulHookWidget {
  const LibraryContent({super.key});

  @override
  State<LibraryContent> createState() => _LibraryContentState();
}

class _LibraryContentState extends State<LibraryContent> {
  late final ScrollController _scrollController;
  final titleKey = GlobalKey(debugLabel: 'titleKey');

  /// position of the floating action button
  double top = 0.0;
  double right = 16.0;

  void updateFABPosition() {
    /// calculate the position of the floating action button
    /// based on titleKey position
    final RenderBox? renderBox =
        titleKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final offset = renderBox.localToGlobal(Offset.zero);
      setState(() {
        final size = renderBox.size;
        final kTop = offset.dy + ((size.height - 56) / 2);
        top = kTop.clamp(context.topPadding + kToolbarHeight - 36, 10000);
      });
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        updateFABPosition();
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        context.topPadding,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
      updateFABPosition();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final padding = context.padding;

    final sortBy = context.select((ConfigCubit cubit) => cubit.sortType);
    final state =
        context.select((LibraryCubit cubit) => cubit.state as LibraryLoaded);
    final sortedMediaItems = state.sortedMediaItems(sortBy);

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverStack(
            insetOnOverlap: true,
            children: [
              MultiSliver(
                children: [
                  LibraryAppBar(state: state, padding: padding),
                  SliverToBoxAdapter(
                    child: Padding(
                      key: titleKey,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ).copyWith(right: 84),
                      child: Typography(
                        state.title + state.title + state.title,
                        secondary: state.subtitle,
                      ),
                    ),
                  ),
                  MediaListView.sliver(sortedMediaItems),
                ],
              ),
              SliverPositioned(
                top: top,
                right: right,
                child: FloatingActionButton(
                  shape: const CircleBorder(),
                  onPressed: () {
                    // TODO: implement
                  },
                  child: const Icon(Icons.play_arrow),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
