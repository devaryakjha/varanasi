import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';

import 'albums.dart';
import 'artists.dart';
import 'playlists.dart';
import 'songs.dart';
import 'top_query.dart';

part 'data.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchResult extends Equatable {
  final TopQuery? topQuery;
  final Songs? songs;
  final Albums? albums;
  final Artists? artists;
  final Playlists? playlists;

  const SearchResult({
    this.topQuery,
    this.songs,
    this.albums,
    this.artists,
    this.playlists,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);

  SearchResult copyWith({
    TopQuery? topQuery,
    Songs? songs,
    Albums? albums,
    Artists? artists,
    Playlists? playlists,
  }) {
    return SearchResult(
      topQuery: topQuery ?? this.topQuery,
      songs: songs ?? this.songs,
      albums: albums ?? this.albums,
      artists: artists ?? this.artists,
      playlists: playlists ?? this.playlists,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      topQuery,
      songs,
      albums,
      artists,
      playlists,
    ];
  }

  List<MediaPlaylist> toMediaPlaylist() {
    final positions = [
      if (topQuery != null) topQuery!,
      if (songs != null) songs!,
      if (albums != null) albums!,
      if (artists != null) artists!,
      if (playlists != null) playlists!,
    ]..sort();
    final mediaPlayList = positions
        .map((e) {
          if (e is TopQuery) {
            return MediaPlaylist(
              mediaItems: e.results,
              title: 'Top Queries',
            );
          } else if (e is Songs) {
            return MediaPlaylist(
              mediaItems: e.results,
              title: 'Songs',
            );
          } else if (e is Albums) {
            return MediaPlaylist(
              mediaItems: e.results,
              title: 'Albums',
            );
          } else if (e is Artists) {
            return MediaPlaylist(
              mediaItems: e.results,
              title: 'Artists',
            );
          } else if (e is Playlists) {
            return MediaPlaylist(
              mediaItems: e.results,
              title: 'Playlists',
            );
          } else {
            throw Exception('Unknown type');
          }
        })
        .where((item) => item.mediaItems?.isNotEmpty ?? false)
        .toList();

    return mediaPlayList;
  }
}
