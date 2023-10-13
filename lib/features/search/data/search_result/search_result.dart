import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'search_result.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchResults extends Equatable {
  final Data? data;
  final String? status;
  final dynamic error;

  const SearchResults({this.data, this.status, this.error});

  factory SearchResults.fromJson(Map<String, dynamic> json) {
    return _$SearchResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);

  SearchResults copyWith({
    Data? data,
    String? status,
    dynamic error,
  }) {
    return SearchResults(
      data: data ?? this.data,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [data, status, error];
}
