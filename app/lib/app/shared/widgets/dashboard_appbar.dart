import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/core/l10n/l10n.dart';
import 'package:varanasi/core/routing/routes.dart';

class DashboardAppbar extends PreferredSize {
  const DashboardAppbar({
    super.key,
  }) : super(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: const SizedBox.shrink(),
        );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppBar(
      toolbarHeight: preferredSize.height,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.greeting('Arya'),
            style: context.bodyMedium.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            l10n.greetingSubtitle,
            style: context.bodySmall.copyWith(color: Colors.grey),
          ),
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
    );
  }
}
