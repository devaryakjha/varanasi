import 'package:flutter/material.dart';

class SectionListViewBuilder<T> extends StatelessWidget {
  const SectionListViewBuilder({
    required this.title,
    required this.itemBuilder,
    this.items = const [],
    super.key,
  });

  final String title;
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
