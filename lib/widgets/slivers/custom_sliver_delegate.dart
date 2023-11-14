// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/search/cubit/search_cubit.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

class CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final EdgeInsets padding;
  final bool showFilter;
  final ValueChanged<String> onSearch;
  final VoidCallback? onClear;
  final TextEditingController? controller;

  CustomHeaderDelegate({
    required this.padding,
    required this.onSearch,
    required this.showFilter,
    this.onClear,
    this.controller,
  });

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    final progress = shrinkOffset / maxExtent;
    return Container(
      height: maxExtent,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        boxShadow:
            overlapsContent ? kElevationToShadow[10] : kElevationToShadow[0],
      ),
      child: Column(
        children: [
          SizedBox(height: topPadding),
          Expanded(
            child: AnimatedOpacity(
              opacity: 1 - progress,
              duration: const Duration(milliseconds: 200),
              child: Row(
                children: [
                  Text(
                    "Search",
                    style: context.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: searchFieldHeight,
            child: CupertinoSearchTextField(
              controller: controller,
              backgroundColor: Colors.white,
              placeholder: "What do you want to listen to?",
              itemColor: Colors.black87,
              placeholderStyle: const TextStyle(color: Colors.black87),
              prefixInsets: const EdgeInsets.symmetric(horizontal: 12),
              itemSize: 24,
              padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 5.5, 8),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              onSubmitted: onSearch,
              autocorrect: false,
              onChanged: onSearch,
              onSuffixTap: onClear,
            ),
          ),
          SizedBox(height: bottomPadding),
          Builder(builder: (context) {
            if (!showFilter) return const SizedBox.shrink();
            final filter =
                context.select((SearchCubit cubit) => cubit.state.filter);
            return Padding(
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: SizedBox(
                height: 36,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                  itemBuilder: (ctx, idx) => Padding(
                    padding: EdgeInsets.zero,
                    child: FilterChip(
                      label: Text(SearchFilter.values[idx].filter),
                      onSelected: (selected) {
                        ctx.read<SearchCubit>().updateFilter(selected
                            ? SearchFilter.values[idx]
                            : SearchFilter.all);
                      },
                      selected: filter == SearchFilter.values[idx],
                    ),
                  ),
                  itemCount: SearchFilter.values.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  double get filterHeight => showFilter ? 52 : 0;

  double get topPadding => padding.top + 16;

  double get bottomPadding => 16;

  double get searchFieldHeight => 48;

  @override
  double get maxExtent => topPadding + 112 + filterHeight;

  @override
  double get minExtent =>
      topPadding + searchFieldHeight + bottomPadding + filterHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent;
  }
}
