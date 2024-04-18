import 'package:flutter/material.dart';
import 'package:varanasi/app/features/media_detail/presentation/pages/media_app_bar.dart';
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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MediaAppBar(title: title, id: id, image: image),
          SliverList.builder(
            itemCount: 1000,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item $index'),
              );
            },
          ),
        ],
      ),
    );
  }
}
