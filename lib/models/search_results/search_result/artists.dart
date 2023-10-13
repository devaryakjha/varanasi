import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'result.dart';

part 'artists.g.dart';

@JsonSerializable(explicitToJson: true)
class Artists extends Equatable {
  final List<Result>? results;
  final int? position;

  const Artists({this.results, this.position});

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
}
