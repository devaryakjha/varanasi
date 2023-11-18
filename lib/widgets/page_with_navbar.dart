import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/utils/constants/nav_items.dart';
import 'package:varanasi_mobile_app/utils/extensions/media_query.dart';
import 'package:varanasi_mobile_app/widgets/player/full_screen_player/full_screen_player.dart';

import 'player/mini_player.dart';

const iconSize = 24.0;

class PageWithNavbar extends HookWidget {
  final StatefulNavigationShell child;
  const PageWithNavbar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final positionState = useState(0.0);
    final bottomNavHeight = 80 + context.bottomPadding;
    final position = positionState.value;
    final opacity = 1 - position;
    final currentHeight = bottomNavHeight * (1 - position);
    final controller = context.select((ConfigCubit cubit) =>
        cubit.state is ConfigLoaded
            ? (cubit.state as ConfigLoaded).panelController
            : null);
    final queue = context
        .select((MediaPlayerCubit cubit) => cubit.state.queueState.queue);
    final showPlayer = controller != null && queue.isNotEmpty;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              bottom: showPlayer ? 56 : 0,
              child: child,
            ),
            if (showPlayer)
              SlidingUpPanel(
                controller: controller,
                renderPanelSheet: false,
                backdropEnabled: true,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                collapsed: MiniPlayer(panelController: controller),
                minHeight: 56,
                maxHeight: context.height,
                panel: position > 0
                    ? Player(panelController: controller)
                    : const SizedBox.shrink(),
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
                  height: bottomNavHeight,
                  indicatorColor: Colors.transparent,
                  selectedIndex: child.currentIndex,
                  onDestinationSelected: (value) {
                    child.goBranch(
                      value,
                      initialLocation: child.currentIndex == value,
                    );
                  },
                  destinations: navItems.map(_createDestination).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  NavigationDestination _createDestination(NavItem e) {
    return NavigationDestination(
      icon: e.icon.svg(
        height: iconSize,
        width: iconSize,
        color: Colors.white,
      ),
      selectedIcon: e.activeIcon.svg(
        height: iconSize,
        width: iconSize,
        color: Colors.white,
      ),
      label: e.label,
    );
  }
}
