import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/widgets/media_tile.dart';

class LibrarySearchPage extends HookWidget {
  final List<PlayableMedia> media;
  const LibrarySearchPage({super.key, required this.media});
  @override
  Widget build(BuildContext context) {
    final filteredMedia = useState(media);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: CupertinoSearchTextField(
                placeholder: 'Find in playlist',
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  final results = extractAllSorted(
                    query: value,
                    choices: media,
                    getter: (obj) => obj.itemTitle,
                  );
                  filteredMedia.value = results.map((e) => e.choice).toList();
                },
              ),
            ),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => MediaTile(
          media: filteredMedia.value[index],
        ),
        itemCount: filteredMedia.value.length,
      ),
    );
  }
}
