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
    return SliverAppBar(
      elevation: 0,
      pinned: true,
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
            PopupMenuItem(
              value: 1,
              child: ListTile(
                dense: true,
                leading: const Icon(Icons.settings_outlined),
                title: Text(l10n.settingsPageTitle),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
