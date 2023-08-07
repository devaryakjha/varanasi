import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';

import 'library_widgets/library_loader.dart';
import 'library_widgets/page.dart';

class LibraryPage extends StatelessWidget {
  final PlayableMedia source;

  const LibraryPage({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((LibraryCubit source) => source.state is LibraryLoading);
    return Visibility(
      visible: !isLoading,
      replacement: const LibraryLoader(),
      child: const PlaylistContent(),
    );
  }
}
