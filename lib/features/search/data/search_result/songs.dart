import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'item_with_position.dart';
import 'result.dart';

part 'songs.g.dart';

@JsonSerializable(explicitToJson: true)
class Songs extends ItemWithPosition with EquatableMixin {
  final List<Result>? results;
  final int _position;

  Songs({this.results, int? position}) : _position = position ?? 0;

  factory Songs.fromJson(Map<String, dynamic> json) => _$SongsFromJson(json);

  Map<String, dynamic> toJson() => _$SongsToJson(this);

  Songs copyWith({
    List<Result>? results,
    int? position,
  }) {
    return Songs(
      results: results ?? this.results,
      position: position ?? this.position,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [results, position];

  @override
  int get position => _position;
}
