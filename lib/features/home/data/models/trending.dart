import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi_mobile_app/models/album.dart';
import 'package:varanasi_mobile_app/models/song.dart';

part 'trending.g.dart';

@JsonSerializable()
@HiveType(typeId: 7)
class Trending extends Equatable {
  @HiveField(0)
  final List<Song>? songs;
  @HiveField(1)
  final List<Album>? albums;

  const Trending({this.songs, this.albums});

  factory Trending.fromJson(Map<String, dynamic> json) {
    return _$TrendingFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TrendingToJson(this);

  Trending copyWith({
    List<Song>? songs,
    List<Album>? albums,
  }) {
    return Trending(
      songs: songs ?? this.songs,
      albums: albums ?? this.albums,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [songs, albums];
}
