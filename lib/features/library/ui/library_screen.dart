import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/playable_item_impl.dart';

import 'library_widgets/library_loader.dart';
import 'library_widgets/page.dart';

class LibraryPage extends StatefulWidget {
  final String id;
  final Object? source;

  const LibraryPage(this.id, {super.key, this.source});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  void initState() {
    super.initState();
    final extra = widget.source!;
    final isMedia = extra is PlayableMedia;
    final isMediaPlaylist = extra is MediaPlaylist;
    if (isMedia) {
      context.read<LibraryCubit>().fetchLibrary(extra);
    } else {
      if (isMediaPlaylist) {
        if (extra.isDownload || extra.isCustomPlaylist) {
          context.read<LibraryCubit>().loadUserLibrary(extra);
        } else {
          final items = extra.mediaItems ?? [];
          if (items.isEmpty) {
            context
                .read<LibraryCubit>()
                .fetchLibrary(PlayableMediaImpl.fromMediaPlaylist(extra));
          } else {
            context.read<LibraryCubit>().loadUserLibrary(extra);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
        (LibraryCubit source) => (source.state[widget.id]?.isLoading ?? false));
    if (isLoading) {
      return const LibraryLoader();
    } else {
      return PopScope(
        onPopInvoked: (didPop) {
          if (didPop) {
            context.read<LibraryCubit>().closeListeners();
          }
        },
        child: LibraryContent(
          id: widget.id,
          source: switch (widget.source) {
            (PlayableMedia media) => media,
            (_) => null,
          },
        ),
      );
    }
  }
}
