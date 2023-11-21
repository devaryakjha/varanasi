import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/features/search/cubit/search_cubit.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';

import 'content.dart';
import 'library_detail_page.dart';

class SearchAndAddToPlaylist extends StatelessWidget {
  final String id;
  final SearchFilter filter;
  final PlayableMedia? media;
  const SearchAndAddToPlaylist(this.id, this.filter, {super.key, this.media});

  @override
  Widget build(BuildContext context) {
    if (filter.isAll) {
      return Material(
        child: Navigator(
          onGenerateRoute: (settings) {
            return MaterialPageRoute<void>(
              builder: (context) => Content(id),
            );
          },
        ),
      );
    }
    if (media == null || !(media?.itemType.isAlbum ?? false)) {
      return Content(id);
    }
    return LibraryDetailPage(id, media!);
  }
}
