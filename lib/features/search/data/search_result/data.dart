// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi_mobile_app/models/album.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/playlist.dart';
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
  @JsonKey(includeFromJson: false, includeToJson: false)
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
final class AllSearchResult extends SearchResult {
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
              id: 'topQueries',
              mediaItems: e.results,
              title: 'Top Queries',
              url: null,
            );
          } else if (e is Songs) {
            return MediaPlaylist(
              id: 'songs',
              mediaItems: e.results,
              title: 'Songs',
              url: null,
            );
          } else if (e is Albums) {
            return MediaPlaylist(
              id: 'albums',
              mediaItems: e.results,
              title: 'Albums',
              url: null,
            );
          } else if (e is Artists) {
            return MediaPlaylist(
              id: 'artists',
              mediaItems: e.results,
              title: 'Artists',
              url: null,
            );
          } else if (e is Playlists) {
            return MediaPlaylist(
              id: 'playlists',
              mediaItems: e.results,
              title: 'Playlists',
              url: null,
            );
          } else {
            throw Exception('Unknown type');
          }
        })
        .where((item) => item.mediaItems?.isNotEmpty ?? false)
        .toList();

    return mediaPlayList;
  }

  List<PlayableMedia> combineMediaItems() {
    final positions = [
      if (songs != null) songs!,
      if (albums != null) albums!,
    ]..sort();
    final mediaPlayList = positions
        .map((e) {
          if (e is Songs) {
            return MediaPlaylist(
              id: 'songs',
              mediaItems: e.results,
              title: 'Songs',
              url: null,
            );
          } else if (e is Albums) {
            return MediaPlaylist(
              id: 'albums',
              mediaItems: e.results,
              title: 'Albums',
              url: null,
            );
          } else {
            throw Exception('Unknown type');
          }
        })
        .where((item) => item.mediaItems?.isNotEmpty ?? false)
        .toList();
    return mediaPlayList
        .expand((element) => element.mediaItems!)
        // .where((item) => item is Song || item is Album)
        .toList();
  }
}

sealed class PaginatedResult<T extends PlayableMedia> extends SearchResult {
  final int? total;
  final int? start;
  final List<T>? results;

  const PaginatedResult({
    required this.total,
    required this.start,
    required SearchType type,
    this.results,
  }) : super(type);

  /// Returns the number of items per page
  int get itemsPerPage => 25;

  /// Returns the current page
  int get currPage => ((((start ?? 1) - 1) / itemsPerPage).floor() + 1);

  /// Returns the next page
  int get nextPage => currPage + 1;

  /// Returns the total number of pages
  int get totalPages => (((total ?? 0) / itemsPerPage).ceil());

  /// Returns true if there is a next page
  bool get hasNextPage => currPage < totalPages;

  /// Returns true if there is a previous page
  bool get isLastPage => currPage == totalPages;

  @override
  List<Object?> get props => [total, start, results];

  PaginatedResult<T> copyFromPaginatedResult(PaginatedResult<T> result) {
    return copyWith(
      total: result.total,
      start: result.start,
      results: [...(results ?? []), ...(result.results ?? [])],
    );
  }

  PaginatedResult<T> copyWith({
    int? total,
    int? start,
    List<T>? results,
  });
}

@JsonSerializable(explicitToJson: true)
final class SongSearchResult extends PaginatedResult<Song> {
  const SongSearchResult({
    super.total = 0,
    super.start = 1,
    super.results,
    super.type = SearchType.songs,
  });

  factory SongSearchResult.fromJson(Map<String, dynamic> json) =>
      _$SongSearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SongSearchResultToJson(this);

  @override
  SongSearchResult copyWith({total, start, results}) {
    return SongSearchResult(
      total: total ?? this.total,
      start: start ?? this.start,
      results: results ?? this.results,
    );
  }
}

@JsonSerializable(explicitToJson: true)
final class AlbumSearchResult extends PaginatedResult<Album> {
  const AlbumSearchResult({
    super.total = 0,
    super.start = 1,
    super.results,
    super.type = SearchType.albums,
  });

  @override
  AlbumSearchResult copyWith({total, start, results}) {
    return AlbumSearchResult(
      total: total ?? this.total,
      start: start ?? this.start,
      results: results ?? this.results,
    );
  }

  factory AlbumSearchResult.fromJson(Map<String, dynamic> json) =>
      _$AlbumSearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumSearchResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
final class PlaylistSearchResult extends PaginatedResult<Playlist> {
  const PlaylistSearchResult({
    super.total = 0,
    super.start = 1,
    super.results,
    super.type = SearchType.playlists,
  });

  @override
  PlaylistSearchResult copyWith({total, start, results}) {
    return PlaylistSearchResult(
      total: total ?? this.total,
      start: start ?? this.start,
      results: results ?? this.results,
    );
  }

  factory PlaylistSearchResult.fromJson(Map<String, dynamic> json) =>
      _$PlaylistSearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistSearchResultToJson(this);
}
