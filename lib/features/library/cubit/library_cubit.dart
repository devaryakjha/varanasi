import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/features/library/data/library_repository.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/sort_type.dart';
import 'package:varanasi_mobile_app/utils/configs.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/helpers/get_app_context.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit() : super(const LibraryInitial());

  static LibraryCubit of(BuildContext context) => context.read<LibraryCubit>();

  Future<void> loadUserLibrary(MediaPlaylist playlist) async {
    try {
      emit(const LibraryLoading());
      String link = playlist.images.last.link!;
      if (!appContext.mounted) return;
      final configCubit = appContext.read<ConfigCubit>();
      if (!appContext.mounted) return;
      final colorPalette = playlist.isDownload && appContext.mounted
          ? PaletteGenerator.fromColors(
              [PaletteColor(appContext.colorScheme.secondaryContainer, 1)])
          : await configCubit.generatePalleteGenerator(link);
      final image = configCubit.getProvider(link);
      emit(LibraryLoaded(playlist, colorPalette!, image));
    } catch (e, s) {
      emit(LibraryError(e, stackTrace: s));
    }
  }

  Future<void> fetchLibrary(PlayableMedia media) async {
    try {
      emit(const LibraryLoading());
      final playlist = await LibraryRepository.instance.fetchLibrary(media);
      String link = playlist.images.last.link!;
      if (link == appConfig.placeholderImageLink) {
        link = media.artworkUrl!;
      }
      if (!appContext.mounted) return;
      final configCubit = appContext.read<ConfigCubit>();
      final colorPalette = await configCubit.generatePalleteGenerator(link);
      final image = configCubit.getProvider(link);
      emit(LibraryLoaded(playlist, colorPalette!, image, media: media));
    } on Exception catch (e, s) {
      LibraryRepository.instance.deleteCache(media.cacheKey);
      emit(LibraryError(e, stackTrace: s));
    }
  }

  void toggleAppbarTitle([bool? expanded]) {
    if (state is LibraryLoaded) {
      emit((state as LibraryLoaded).toggleAppbarTitle(expanded));
    }
  }
}
