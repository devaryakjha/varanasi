import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/user-library/cubit/user_library_cubit.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/song.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.media,
  });

  final PlayableMedia? media;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLibraryCubit, UserLibraryState>(
      builder: (context, state) {
        final source = media;
        if (state is! UserLibraryLoaded || source == null || source is! Song) {
          return const SizedBox.shrink();
        }
        final isAdded = state.favorite?.mediaItems
                ?.any((item) => item.itemId == source.id) ??
            false;
        return IconButton(
          onPressed: Feedback.wrapForTap(() {
            final cubit = context.read<UserLibraryCubit>();
            if (isAdded) {
              cubit.unfavoriteSong(source);
            } else {
              cubit.favoriteSong(source);
            }
          }, context),
          icon: isAdded
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border_rounded),
          color: isAdded ? Colors.red : null,
        );
      },
    );
  }
}
