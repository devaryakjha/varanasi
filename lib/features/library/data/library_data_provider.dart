import 'package:flutter/foundation.dart';
import 'package:varanasi_mobile_app/models/image.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';
import 'package:varanasi_mobile_app/utils/mixins/repository_protocol.dart';
import 'package:varanasi_mobile_app/utils/services/http_services.dart';

class LibraryDataProvider with DataProviderProtocol {
  Logger get _logger => Logger.instance;
  LibraryDataProvider._();
  static final instance = LibraryDataProvider._();

  Future<(dynamic, MediaPlaylist<Song>?)> fetchLibrary(
      PlayableMedia media) async {
    try {
      final uri = media.moreInfoUrl;
      return await fetch(
        '/${uri.path}',
        queryParameters: uri.queryParameters,
        options: CommonOptions(
          transformer: (response) async {
            final response1 = await compute(
                parseMediaPlaylist, response as Map<String, dynamic>);
            return response1;
          },
        ),
      );
    } catch (e) {
      return (e, null);
    }
  }

  MediaPlaylist<Song> parseMediaPlaylist(Map<String, dynamic> json) {
    try {
      final List<Song> songs = json['songs'] != null
          ? List<Song>.from(json['songs'].map((x) => Song.fromJson(x)))
          : [];
      final List<Image> images = json['image'] != null
          ? List<Image>.from(json['image'].map((x) => Image.fromJson(x)))
          : [];
      return MediaPlaylist(
        id: json['id'],
        description: json['description'],
        title: json['name'],
        mediaItems: songs,
        images: images,
      );
    } on Exception {
      return MediaPlaylist(
        id: json['id'],
        mediaItems: const [],
      );
    }
  }
}
