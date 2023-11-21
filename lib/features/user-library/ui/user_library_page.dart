import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/cubits/download/download_cubit.dart';
import 'package:varanasi_mobile_app/features/user-library/cubit/user_library_cubit.dart';
import 'package:varanasi_mobile_app/features/user-library/ui/widgets/add_playlist_button.dart';
import 'package:varanasi_mobile_app/gen/assets.gen.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/helpers/get_app_context.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';
import 'package:varanasi_mobile_app/widgets/animated_overflow_text.dart';
import 'package:varanasi_mobile_app/widgets/downloads_icon.dart';

import 'widgets/empty.dart';

class UserLibraryPage extends HookWidget {
  const UserLibraryPage({super.key});

  DownloadCubit get downloadCubit => appContext.read<DownloadCubit>();
  Stream<MediaPlaylist> get downloadLibraryStream =>
      downloadCubit.downloadLibraryStream;

  @override
  Widget build(BuildContext context) {
    final downloadSnapshot = useStream(
      downloadLibraryStream,
      initialData: downloadCubit.toUserLibrary(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Assets.icon.appIconMonotone.svg(width: 36, height: 36),
            const SizedBox(width: 8),
            Text(
              'Your Library',
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: false,
        actions: const [AddPlaylistButton()],
        elevation: 10,
      ),
      body: BlocBuilder<UserLibraryCubit, UserLibraryState>(
        builder: (context, state) {
          if (state is! UserLibraryLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          final library = [...state.library, downloadSnapshot.data]
              .whereType<MediaPlaylist>()
              .where((element) =>
                  (!element.isFavorite && !element.isDownload) ||
                  element.isNotEmpty)
              .toList()
            ..sort();
          if (library.isEmpty) return const EmptyUserLibrary();
          return ListView.builder(
            itemBuilder: (context, index) {
              final item = library[index];
              return ListTile(
                onTap: () {
                  context.pushNamed(
                    AppRoutes.library.name,
                    extra: item,
                    pathParameters: {'id': item.id},
                  );
                },
                leading: Visibility(
                  replacement: const DownloadsIcon(),
                  visible: !item.isDownload,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: item.images.lastOrNull?.link ?? '',
                      height: 48,
                      width: 48,
                    ),
                  ),
                ),
                title: SizedBox(
                  height: 24,
                  child: AnimatedText(
                    (item.title ?? '').sanitize,
                    maxLines: 1,
                    minFontSize: 14,
                  ),
                ),
                subtitle: Row(
                  children: [
                    if (item.isDownload || item.isFavorite)
                      Icon(
                        Icons.push_pin_rounded,
                        size: 12,
                        color: context.colorScheme.primary,
                      ),
                    Expanded(child: Text(item.description ?? '')),
                  ],
                ),
              );
            },
            itemCount: library.length,
          );
        },
      ),
    );
  }
}
