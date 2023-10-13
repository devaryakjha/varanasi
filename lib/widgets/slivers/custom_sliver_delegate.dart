// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

class CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final EdgeInsets padding;
  CustomHeaderDelegate({
    required this.padding,
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
            child: const CupertinoSearchTextField(
              backgroundColor: Colors.white,
              placeholder: "What do you want to listen to?",
              itemColor: Colors.black87,
              placeholderStyle: TextStyle(color: Colors.black87),
              prefixInsets: EdgeInsets.symmetric(horizontal: 12),
              itemSize: 24,
              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 5.5, 8),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
          ),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }

  double get topPadding => padding.top + 16;

  double get bottomPadding => 16;

  double get searchFieldHeight => 48;

  @override
  double get maxExtent => topPadding + 112;

  @override
  double get minExtent => topPadding + searchFieldHeight + bottomPadding;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
