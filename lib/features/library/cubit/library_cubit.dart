import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/cubits/download/download_cubit.dart';
import 'package:varanasi_mobile_app/features/library/data/library_repository.dart';
import 'package:varanasi_mobile_app/features/user-library/data/user_library_repository.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/sort_type.dart';
import 'package:varanasi_mobile_app/utils/configs.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/helpers/get_app_context.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit() : super(const LibraryState());

  static LibraryCubit of(BuildContext context) => context.read<LibraryCubit>();

  StreamSubscription? _subscription;

  Future<void> loadUserLibrary(MediaPlaylist playlist) async {
    try {
      emit(state + MediaLoadingState(playlist.id));
      String link = playlist.images.last.link!;
      if (!appContext.mounted) return;
      final configCubit = appContext.read<ConfigCubit>();
      if (!appContext.mounted) return;
      final colorPalette = playlist.isDownload && appContext.mounted
          ? PaletteGenerator.fromColors(
              [PaletteColor(appContext.colorScheme.secondaryContainer, 1)])
          : await configCubit.generatePalleteGenerator(link);
      final image = configCubit.getProvider(link);
      if (!appContext.mounted) return;
      if (playlist.isDownload) {
        final newPlaylist = appContext.read<DownloadCubit>().toUserLibrary();
        emit(state +
            MediaLoadedState(playlist.id, newPlaylist, colorPalette!, image));
      } else if (playlist.isCustomPlaylist) {
        _subscription =
            UserLibraryRepository.instance.librariesStream.where((event) {
          final isSame = event.any((element) => element.id == playlist.id);
          return isSame;
        }).listen((event) {
          final newPlaylist =
              event.firstWhereOrNull((element) => element.id == playlist.id);
          if (newPlaylist != null) {
            emit(
              state +
                  MediaLoadedState(
                    newPlaylist.id,
                    newPlaylist,
                    colorPalette!,
                    image,
                  ),
            );
          }
        });
      } else {
        emit(
          state + MediaLoadedState(playlist.id, playlist, colorPalette!, image),
        );
      }
    } catch (e, s) {
      Logger.instance.e(e);
      emit(LibraryError(e, stackTrace: s));
    }
  }

  Future<void> fetchLibrary(PlayableMedia media) async {
    try {
      emit(state + MediaLoadingState(media.itemId));
      final playlist = await LibraryRepository.instance.fetchLibrary(media);
      String link = playlist.images.last.link!;
      if (link == appConfig.placeholderImageLink) {
        link = media.artworkUrl!;
      }
      if (!appContext.mounted) return;
      final configCubit = appContext.read<ConfigCubit>();
      final colorPalette = await configCubit.generatePalleteGenerator(link);
      final image = configCubit.getProvider(link);
      emit(state +
          MediaLoadedState(playlist.id, playlist, colorPalette!, image));
    } on Exception catch (e, s) {
      LibraryRepository.instance.deleteCache(media.cacheKey);
      emit(LibraryError(e, stackTrace: s));
    }
  }

  void toggleAppbarTitle(String id, [bool? expanded]) {
    if (state[id] != null) {
      emit(state + (state[id] as MediaLoadedState).toggleAppbarTitle(expanded));
    }
  }

  void closeListeners() => _subscription?.cancel();
}
