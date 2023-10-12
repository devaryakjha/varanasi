// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

import 'sort_type.dart';

part 'app_config.g.dart';

@HiveType(typeId: 13)
class AppConfig extends HiveObject with EquatableMixin {
  @HiveField(0, defaultValue: SortBy.custom)
  final SortBy sortBy;
  @HiveField(1, defaultValue: 0)
  final int repeatMode;

  AppConfig({
    this.sortBy = SortBy.custom,
    this.repeatMode = 0,
  });

  @override
  List<Object?> get props => [sortBy, repeatMode];

  AppConfig copyWith({
    SortBy? sortBy,
    int? repeatMode,
  }) {
    return AppConfig(
      sortBy: sortBy ?? this.sortBy,
      repeatMode: repeatMode ?? this.repeatMode,
    );
  }
}
