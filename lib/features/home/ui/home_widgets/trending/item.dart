import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/extensions/strings.dart';
import 'package:varanasi_mobile_app/utils/extensions/theme.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';

class TrendingItem extends StatelessWidget {
  final PlayableMedia media;

  const TrendingItem(this.media, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: switch (media.itemType) {
          PlayableMediaType.song => () {
              context.readMediaPlayerCubit.playFromSong(media);
            },
          _ => () => context.pushNamed(
                AppRoutes.library.name,
                extra: media,
                pathParameters: {'id': media.itemId},
              ),
        },
        child: Container(
          height: 56,
          padding: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade900,
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                width: 56,
                height: 56,
                imageUrl: media.artworkUrl ?? '',
                fit: BoxFit.cover,
                placeholder: (_, __) => const SizedBox.square(dimension: 56),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  media.itemTitle.sanitize,
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
