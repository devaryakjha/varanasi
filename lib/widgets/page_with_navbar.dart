import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/utils/extensions/media_query.dart';
import 'package:varanasi_mobile_app/widgets/player/full_screen_player/flutter_screen_player.dart';

import 'player/mini_player.dart';

const bottomNavHeight = 114.0;

class PageWithNavbar extends HookWidget {
  final StatefulNavigationShell child;
  const PageWithNavbar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final positionState = useState(0.0);
    final position = positionState.value;
    final opacity = 1 - position;
    final currentHeight = bottomNavHeight * (1 - position);
    final controller = context.select((ConfigCubit cubit) =>
        cubit.state is ConfigLoaded
            ? (cubit.state as ConfigLoaded).panelController
            : null);
    final queue = context
        .select((MediaPlayerCubit cubit) => cubit.state.queueState.queue);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: child),
          if (controller != null && queue.isNotEmpty)
            SlidingUpPanel(
              controller: controller,
              renderPanelSheet: false,
              backdropEnabled: true,
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              collapsed: MiniPlayer(panelController: controller),
              minHeight: 56,
              maxHeight: context.height,
              panel: Player(panelController: controller),
              onPanelSlide: (pos) => positionState.value = pos,
            ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: currentHeight,
        child: Transform.translate(
          offset: Offset(0.0, currentHeight * position * 0.5),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: opacity,
            child: OverflowBox(
              maxHeight: bottomNavHeight,
              child: NavigationBar(
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
            ),
          ),
        ),
      ),
    );
  }
}
