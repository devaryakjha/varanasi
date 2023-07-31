import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageWithNavbar extends StatelessWidget {
  final StatefulNavigationShell child;
  const PageWithNavbar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: child);
  }
}
