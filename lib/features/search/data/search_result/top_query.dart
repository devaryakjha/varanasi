import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'item_with_position.dart';
import 'result.dart';

part 'top_query.g.dart';

@JsonSerializable(explicitToJson: true)
class TopQuery extends ItemWithPosition with EquatableMixin {
  final List<Result>? results;
  final int _position;

  TopQuery({this.results, int? position}) : _position = position ?? 0;

  factory TopQuery.fromJson(Map<String, dynamic> json) {
    return _$TopQueryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TopQueryToJson(this);

  TopQuery copyWith({
    List<Result>? results,
    int? position,
  }) {
    return TopQuery(
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
