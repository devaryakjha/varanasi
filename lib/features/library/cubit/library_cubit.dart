import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:varanasi_mobile_app/features/library/data/library_repository.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/sort_type.dart';
import 'package:varanasi_mobile_app/utils/configs.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/generate_pallette.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit() : super(const LibraryInitial());

  Future<void> fetchLibrary(PlayableMedia media) async {
    try {
      emit(const LibraryLoading());
      final playlist = await LibraryRepository.instance.fetchLibrary(media);
      String link = playlist.images.last.link!;
      if (link == appConfig.placeholderImageLink) {
        link = media.artworkUrl!;
      }
      final image = CachedNetworkImageProvider(link);
      final colorPalette = await generateColorPalette(imageProvider: image);
      emit(LibraryLoaded(playlist, colorPalette!, image));
    } on Exception catch (e, s) {
      LibraryRepository.instance.deleteCache(media.cacheKey);
      emit(LibraryError(e, stackTrace: s));
    }
  }

  void sortBy(SortBy sortBy) {
    emit((state as LibraryLoaded).copyWith(sortBy: sortBy));
  }
}
