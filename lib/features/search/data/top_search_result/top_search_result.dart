import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'top_search.dart';

part 'top_search_result.g.dart';

@JsonSerializable()
class TopSearchResult extends Equatable {
  final String? status;
  final List<TopSearch>? data;
  final dynamic error;

  const TopSearchResult({this.status, this.data, this.error});

  factory TopSearchResult.fromJson(Map<String, dynamic> json) {
    return _$TopSearchResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TopSearchResultToJson(this);

  TopSearchResult copyWith({
    String? status,
    List<TopSearch>? data,
    dynamic error,
  }) {
    return TopSearchResult(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, data, error];
}
