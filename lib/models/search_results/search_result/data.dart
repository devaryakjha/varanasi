import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'albums.dart';
import 'artists.dart';
import 'playlists.dart';
import 'songs.dart';
import 'top_query.dart';

part 'data.g.dart';

@JsonSerializable(explicitToJson: true)
class Data extends Equatable {
  final TopQuery? topQuery;
  final Songs? songs;
  final Albums? albums;
  final Artists? artists;
  final Playlists? playlists;

  const Data({
    this.topQuery,
    this.songs,
    this.albums,
    this.artists,
    this.playlists,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  Data copyWith({
    TopQuery? topQuery,
    Songs? songs,
    Albums? albums,
    Artists? artists,
    Playlists? playlists,
  }) {
    return Data(
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
}
