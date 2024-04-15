import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    required this.navigationShell,
    required this.children,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: children[navigationShell.currentIndex],
      ),
      // bottomNavigationBar: NavigationBar(
      //   height: 60,
      //   selectedIndex: navigationShell.currentIndex,
      //   onDestinationSelected: (index) {
      //     navigationShell.goBranch(
      //       index,
      //       initialLocation: index == navigationShell.currentIndex,
      //     );
      //   },
      //   destinations: const [
      //     NavigationDestination(
      //       icon: Icon(Icons.home_outlined),
      //       selectedIcon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.search),
      //       selectedIcon: Icon(Icons.search),
      //       label: 'Search',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.library_books_outlined),
      //       selectedIcon: Icon(Icons.library_books),
      //       label: 'Your Library',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.person_2_outlined),
      //       selectedIcon: Icon(Icons.person_2),
      //       label: 'Account',
      //     ),
      //   ],
      // ),
    );
  }
}
