import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/widgets/player/mini_player.dart';

class PageWithNavbar extends StatelessWidget {
  final StatefulNavigationShell child;
  const PageWithNavbar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const MiniPlayer(),
    );
  }
}
