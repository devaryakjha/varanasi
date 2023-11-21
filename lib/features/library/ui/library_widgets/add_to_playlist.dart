import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';

class AddToPlaylist extends StatelessWidget {
  const AddToPlaylist(
    this.id, {
    super.key,
    required this.name,
    required this.backgroundColor,
    required this.foregroundColor,
    this.isEmpty = true,
  });

  final String id;
  final String name;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    if (isEmpty) {
      return Column(
        children: [
          const SizedBox(height: 32),
          Text(
            'Let\'s add some songs to this playlist!',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.75,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: backgroundColor,
            ),
            onPressed: () => context.pushNamed(
              AppRoutes.addToLibrary.name,
              pathParameters: {'id': id},
              extra: name,
            ),
            child: Text(
              'Add to this playlist',
              style: context.textTheme.bodyMedium?.copyWith(
                color: foregroundColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.75,
              ),
            ),
          )
        ],
      );
    }
    return ListTile(
      onTap: () => context.pushNamed(
        AppRoutes.addToLibrary.name,
        pathParameters: {'id': id},
        extra: name,
      ),
      leading: Container(
        height: 56,
        width: 56,
        color: Colors.grey.shade900,
        child: const Icon(Icons.add),
      ),
      title: const Text('Add to this playlist'),
    );
  }
}
