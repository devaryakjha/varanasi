import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';

class AddPlaylistButton extends StatelessWidget {
  const AddPlaylistButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.pushNamed(AppRoutes.createLibrary.name),
      icon: const Icon(Icons.add_rounded),
    );
  }
}
