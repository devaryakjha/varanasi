import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:varanasi_mobile_app/features/library/data/library_repository.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
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
      final image = CachedNetworkImageProvider(playlist.images.last.link!);
      final colorPalette = await generateColorPalette(imageProvider: image);
      emit(LibraryLoaded(playlist, colorPalette!, image));
    } on Exception catch (e, s) {
      emit(LibraryError(e, stackTrace: s));
    }
  }
}
