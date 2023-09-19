// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

import 'sort_type.dart';

part 'app_config.g.dart';

@HiveType(typeId: 13)
class AppConfig extends HiveObject with EquatableMixin {
  @HiveField(0)
  final SortBy sortBy;

  AppConfig({this.sortBy = SortBy.custom});

  @override
  List<Object?> get props => [sortBy];

  AppConfig copyWith({
    SortBy? sortBy,
  }) {
    return AppConfig(
      sortBy: sortBy ?? this.sortBy,
    );
  }
}
