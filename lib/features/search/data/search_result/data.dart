import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/song.dart';

import 'albums.dart';
import 'artists.dart';
import 'playlists.dart';
import 'songs.dart';
import 'top_query.dart';

part 'data.g.dart';

@JsonEnum(valueField: 'type')
enum SearchType {
  all._('all'),
  songs._('songs'),
  albums._('albums'),
  artists._('artists'),
  playlists._('playlists');

  const SearchType._(this.type);

  final String type;
}

sealed class SearchResult extends Equatable {
  final SearchType type;

  const SearchResult(this.type);

  @override
  List<Object?> get props => [type];

  bool get isAll => type == SearchType.all;
  bool get isSongs => type == SearchType.songs;
  bool get isAlbums => type == SearchType.albums;
  bool get isArtists => type == SearchType.artists;
  bool get isPlaylists => type == SearchType.playlists;
}

@JsonSerializable(explicitToJson: true)
class AllSearchResult extends SearchResult {
  final TopQuery? topQuery;
  final Songs? songs;
  final Albums? albums;
  final Artists? artists;
  final Playlists? playlists;

  const AllSearchResult({
    this.topQuery,
    this.songs,
    this.albums,
    this.artists,
    this.playlists,
  }) : super(SearchType.all);

  factory AllSearchResult.fromJson(Map<String, dynamic> json) =>
      _$AllSearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$AllSearchResultToJson(this);

  AllSearchResult copyWith({
    TopQuery? topQuery,
    Songs? songs,
    Albums? albums,
    Artists? artists,
    Playlists? playlists,
  }) {
    return AllSearchResult(
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
      type,
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

@JsonSerializable(explicitToJson: true)
class SongSearchResult extends SearchResult {
  final int? total;
  final int? start;
  final List<Song>? results;

  const SongSearchResult({
    this.total,
    this.start,
    this.results,
  }) : super(SearchType.songs);

  @override
  List<Object?> get props => [total, start, results];

  factory SongSearchResult.fromJson(Map<String, dynamic> json) =>
      _$SongSearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SongSearchResultToJson(this);
}
