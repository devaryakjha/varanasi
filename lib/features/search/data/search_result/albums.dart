import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'item_with_position.dart';
import 'result.dart';

part 'albums.g.dart';

@JsonSerializable(explicitToJson: true)
class Albums extends ItemWithPosition with EquatableMixin {
  final List<Result>? results;
  final int _position;

  Albums({this.results, int? position}) : _position = position ?? 0;

  factory Albums.fromJson(Map<String, dynamic> json) {
    return _$AlbumsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AlbumsToJson(this);

  Albums copyWith({
    List<Result>? results,
    int? position,
  }) {
    return Albums(
      results: results ?? this.results,
      position: position ?? this.position,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [results, _position];

  @override
  int get position => _position;
}
