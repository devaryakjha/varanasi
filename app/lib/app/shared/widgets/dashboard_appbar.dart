import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/core/l10n/l10n.dart';
import 'package:varanasi/core/routing/routes.dart';

class DashboardAppbar extends StatelessWidget {
  const DashboardAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverAppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.greeting('Arya'), style: context.titleSmall),
            Text(l10n.greetingSubtitle, style: context.bodySmall),
          ],
        ),
        actions: [
          PopupMenuButton(
            onSelected: (route) {
              switch (route) {
                case 1:
                  const SettingsRouteData().push<void>(context);
              }
            },
            position: PopupMenuPosition.under,
            offset: const Offset(0, 16),
            icon: CircleAvatar(child: RandomAvatar('Arya')),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: ListTile(
                  dense: true,
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
