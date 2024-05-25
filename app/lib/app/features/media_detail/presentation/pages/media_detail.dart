import 'package:flutter/material.dart';
import 'package:varanasi/app/features/media_detail/presentation/pages/artists_detail.dart';
import 'package:varanasi/app/shared/domain/entities/media_type.dart';

class MediaDetailPage extends StatelessWidget {
  const MediaDetailPage({
    required this.image,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    super.key,
  });

  final MediaType type;
  final String image;
  final String id;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      MediaType.artist => ArtistDetailPage(
          image: image,
          id: id,
          title: title,
          subtitle: subtitle,
        ),
      _ => Scaffold(
          body: Center(
            child: Text('Media Detail Page: $type'),
          ),
        ),
    };
  }
}
