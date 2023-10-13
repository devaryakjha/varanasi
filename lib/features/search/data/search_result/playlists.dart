import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'result.dart';

part 'playlists.g.dart';

@JsonSerializable(explicitToJson: true)
class Playlists extends Equatable {
  final List<Result>? results;
  final int? position;

  const Playlists({this.results, this.position});

  factory Playlists.fromJson(Map<String, dynamic> json) {
    return _$PlaylistsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PlaylistsToJson(this);

  Playlists copyWith({
    List<Result>? results,
    int? position,
  }) {
    return Playlists(
      results: results ?? this.results,
      position: position ?? this.position,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [results, position];
}
