import 'package:hive_flutter/hive_flutter.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';

part 'playable_item_impl.g.dart';

@HiveType(typeId: 24)
class PlayableMediaImpl extends PlayableMedia {
  @HiveField(0)
  final String _itemId;
  @HiveField(1)
  final String _itemTitle;
  @HiveField(2)
  final String _itemSubtitle;
  @HiveField(3)
  final String _itemUrl;
  @HiveField(4)
  final String _itemType;
  @HiveField(5)
  final String? _artworkUrl;

  const PlayableMediaImpl(
    this._itemId,
    this._itemTitle,
    this._itemSubtitle,
    this._itemUrl,
    this._itemType,
    this._artworkUrl,
  );

  @override
  String? get artworkUrl => _artworkUrl;

  @override
  String get itemId => _itemId;

  @override
  String get itemSubtitle => _itemSubtitle;

  @override
  String get itemTitle => _itemTitle;

  @override
  PlayableMediaType get itemType => PlayableMediaType.fromString(_itemType);

  @override
  String get itemUrl => _itemUrl;

  Map<String, dynamic> toFirestorePayload() {
    return {
      'id': _itemId,
      'title': _itemTitle,
      'subtitle': _itemSubtitle,
      'url': _itemUrl,
      'type': _itemType,
      'artworkUrl': _artworkUrl,
    };
  }

  factory PlayableMediaImpl.fromFirestorePayload(Map<String, dynamic> payload) {
    return PlayableMediaImpl(
      payload['id'],
      payload['title'],
      payload['subtitle'],
      payload['url'],
      payload['type'],
      payload['artworkUrl'],
    );
  }

  factory PlayableMediaImpl.fromMediaPlaylist(MediaPlaylist mediaPlaylist) {
    return PlayableMediaImpl(
      mediaPlaylist.id,
      mediaPlaylist.title!,
      mediaPlaylist.description!,
      mediaPlaylist.url ?? '',
      mediaPlaylist.type!,
      mediaPlaylist.images.lastOrNull?.link,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'itemId': _itemId,
      'itemTitle': _itemTitle,
      'itemSubtitle': _itemSubtitle,
      'itemUrl': _itemUrl,
      'itemType': _itemType,
      'artworkUrl': _artworkUrl,
    };
  }
}
