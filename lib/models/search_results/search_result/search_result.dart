import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'search_result.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchResult extends Equatable {
  final Data? data;
  final String? status;
  final dynamic error;

  const SearchResult({this.data, this.status, this.error});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return _$SearchResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);

  SearchResult copyWith({
    Data? data,
    String? status,
    dynamic error,
  }) {
    return SearchResult(
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
