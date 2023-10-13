import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'result.dart';

part 'albums.g.dart';

@JsonSerializable(explicitToJson: true)
class Albums extends Equatable {
  final List<Result>? results;
  final int? position;

  const Albums({this.results, this.position});

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
  List<Object?> get props => [results, position];
}
