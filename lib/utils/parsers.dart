import 'package:varanasi_mobile_app/models/album.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/playlist.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/types/types.dart';

PlayableMedia parsePlayableMedia(JSON json) {
  return switch (PlayableMediaType.fromString(json['type'])) {
    PlayableMediaType.song => Song.fromJson(json),
    PlayableMediaType.album => Album.fromJson(json),
    PlayableMediaType.playlist => Playlist.fromJson(json),
    _ => throw Exception('Invalid PlayableMedia type'),
  };
}

List<PlayableMedia> parsePlayableMediaList(JSONList list) =>
    list.map(parsePlayableMedia).toList();
