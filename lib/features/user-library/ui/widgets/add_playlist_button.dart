import 'package:flutter/material.dart' hide Image;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nanoid/nanoid.dart';
import 'package:varanasi_mobile_app/features/session/cubit/session_cubit.dart';
import 'package:varanasi_mobile_app/features/user-library/cubit/user_library_cubit.dart';
import 'package:varanasi_mobile_app/models/image.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/utils/configs.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';

class AddPlaylistButton extends StatelessWidget {
  const AddPlaylistButton({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = context.select((SessionCubit cubit) =>
        cubit.state is Authenticated
            ? (cubit.state as Authenticated).user.displayName
            : '');
    return IconButton(
      onPressed: () async {
        final name =
            await context.pushNamed<String?>(AppRoutes.createLibrary.name);
        if (context.mounted && name != null && name.isNotEmpty) {
          context
              .read<UserLibraryCubit>()
              .addToLibrary(
                MediaPlaylist(
                  id: nanoid(),
                  url: '',
                  title: name,
                  mediaItems: const [],
                  description:
                      userName == null ? 'Playlist' : 'Playlist • $userName',
                  images: [Image.fromString(appConfig.placeholderImageLink)],
                  type: MediaPlaylistType.customPlaylist.type,
                ),
              )
              .then((value) {
            context.read<SessionCubit>().incrementCustomPlaylistIndex();
          });
        }
      },
      icon: const Icon(Icons.add_rounded),
    );
  }
}
