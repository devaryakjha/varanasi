import 'package:hive_flutter/hive_flutter.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/features/user-library/data/user_library.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/helpers/get_app_context.dart';

import 'playable_item_impl.dart';

part 'recent_media.g.dart';

@HiveType(typeId: 23)
class RecentMedia extends PlayableMedia implements Comparable<RecentMedia> {
  @HiveField(0)
  final String _itemId;
  @HiveField(1)
  final DateTime lastPlayed;
  @HiveField(2)
  final UserLibrary? sourceLibrary;
  @HiveField(3)
  final PlayableMediaImpl? sourceMedia;

  const RecentMedia(
    this._itemId,
    this.lastPlayed,
    this.sourceLibrary,
    this.sourceMedia,
  );

  factory RecentMedia.fromPlayableMedia(PlayableMedia media) => RecentMedia(
        media.itemId,
        DateTime.now(),
        null,
        media.toPlayableMediaImpl(),
      );

  factory RecentMedia.fromUserLibrary(UserLibrary library) => RecentMedia(
        library.id,
        DateTime.now(),
        library,
        null,
      );

  factory RecentMedia.fromLibraryCubit() {
    final cubit = LibraryCubit.of(appContext);
    if (cubit.state is LibraryLoaded) {
      final loadedState = cubit.state as LibraryLoaded;
      final source = loadedState.sourceLibrary;
      if (source != null) {
        return RecentMedia.fromUserLibrary(source);
      }
      final media = loadedState.media;
      if (media != null) {
        return RecentMedia.fromPlayableMedia(media);
      }
      return RecentMedia(loadedState.title, DateTime.now(), null, null);
    }
    return RecentMedia('', DateTime.now(), null, null);
  }

  @override
  String? get artworkUrl =>
      sourceMedia?.artworkUrl ?? sourceLibrary?.images.last.link ?? '';

  @override
  String get itemId => _itemId;

  @override
  String get itemSubtitle =>
      sourceMedia?.itemSubtitle ?? sourceLibrary?.description ?? '';

  @override
  String get itemTitle => sourceMedia?.itemTitle ?? sourceLibrary?.title ?? '';

  @override
  PlayableMediaType get itemType =>
      sourceMedia?.itemType ?? PlayableMediaType.album;

  @override
  String get itemUrl => sourceMedia?.itemUrl ?? '';

  @override
  List<Object?> get props => [
        _itemId,
        lastPlayed,
        sourceLibrary,
        sourceMedia,
      ];

  @override
  int compareTo(other) => other.lastPlayed.compareTo(lastPlayed);
}
