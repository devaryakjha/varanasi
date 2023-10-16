import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'item_with_position.dart';
import 'result.dart';

part 'artists.g.dart';

@JsonSerializable(explicitToJson: true)
class Artists extends ItemWithPosition with EquatableMixin {
  final List<Result>? results;
  final int _position;

  Artists({this.results, int? position}) : _position = position ?? 0;

  factory Artists.fromJson(Map<String, dynamic> json) {
    return _$ArtistsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ArtistsToJson(this);

  Artists copyWith({
    List<Result>? results,
    int? position,
  }) {
    return Artists(
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
