import 'package:flutter/material.dart';
import 'package:varanasi/app/shared/shared.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        DashboardAppbar(),
      ],
    );
  }
}
