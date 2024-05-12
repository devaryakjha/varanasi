import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/app/features/media_detail/domain/entities/artist_bio.dart';

class ArtistBioPage extends StatelessWidget {
  const ArtistBioPage({
    required this.bio,
    required this.id,
    super.key,
  });

  final List<Bio> bio;

  final String id;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: PageStorageKey('bio_$id'),
      padding: EdgeInsets.zero,
      itemCount: bio.length + 1,
      itemBuilder: (context, index) {
        if (index == bio.length) {
          return Gap(context.padding.bottom);
        }
        final item = bio[index];
        return ListTile(
          isThreeLine: true,
          titleTextStyle: context.titleMedium,
          title: Text(item.title),
          subtitle: SelectableText(
            key: PageStorageKey('bio_${id}_$index'),
            item.text,
            scrollPhysics: const NeverScrollableScrollPhysics(),
          ),
          subtitleTextStyle: context.bodyMedium,
        );
      },
    );
  }
}
