import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

class EmptyUserLibrary extends StatelessWidget {
  const EmptyUserLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Add music to your library",
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Collect your favorites so that you can listen\nwhenever you want",
            style: context.textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
