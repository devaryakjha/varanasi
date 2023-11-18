import 'package:flutter/foundation.dart';
import 'package:varanasi_mobile_app/models/image.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/mixins/repository_protocol.dart';
import 'package:varanasi_mobile_app/utils/services/http_services.dart';

class LibraryDataProvider with DataProviderProtocol {
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
              parseMediaPlaylist,
              response as Map<String, dynamic>,
            );
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
      final description = keepIteratingTillNotNull<String>(
        ['description', 'subtitle', 'firstname', 'type'],
        json,
        () => '',
      ).capitalize;
      final url = keepIteratingTillNotNull<String>(
        ['url', 'link'],
        json,
        () => '',
      );
      return MediaPlaylist(
        id: json['id'],
        description: description,
        title: json['name'],
        mediaItems: songs,
        images: images,
        url: url,
        type: json['type'],
      );
    } on Exception {
      return MediaPlaylist(
        id: json['id'],
        mediaItems: const [],
        url: null,
      );
    }
  }
}

T keepIteratingTillNotNull<T>(
  List<String> keys,
  Map<String, dynamic> json,
  T Function()? orElse,
) {
  for (final key in keys) {
    final value = json[key];
    if (value != null) {
      if (value is String && value.isEmpty) {
        continue;
      }
      return json[key] as T;
    }
  }
  if (orElse != null) {
    return orElse();
  }
  throw Exception('No valid key found');
}
