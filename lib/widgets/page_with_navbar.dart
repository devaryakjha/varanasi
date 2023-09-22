import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'player/mini_player.dart';

class PageWithNavbar extends StatelessWidget {
  final StatefulNavigationShell child;
  const PageWithNavbar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: child),
          const Positioned(
            bottom: 0,
            right: 8,
            left: 8,
            height: 56,
            child: MiniPlayer(),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        surfaceTintColor: Colors.transparent,
        selectedIndex: child.currentIndex,
        onDestinationSelected: (value) {
          FlushbarHelper.createError(
            message: 'Coming soon!',
            duration: const Duration(seconds: 1),
          ).show(context);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.library_music_outlined),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}
