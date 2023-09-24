// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

import 'sort_type.dart';

part 'app_config.g.dart';

@HiveType(typeId: 13)
class AppConfig extends HiveObject with EquatableMixin {
  @HiveField(0)
  final SortBy sortBy;
  @HiveField(1)
  final int repeatMode;
  @HiveField(2)
  final int shuffleMode;

  AppConfig({
    this.sortBy = SortBy.custom,
    this.repeatMode = 0,
    this.shuffleMode = 0,
  });

  @override
  List<Object?> get props => [sortBy, repeatMode, shuffleMode];

  AppConfig copyWith({
    SortBy? sortBy,
    int? repeatMode,
    int? shuffleMode,
  }) {
    return AppConfig(
      sortBy: sortBy ?? this.sortBy,
      repeatMode: repeatMode ?? this.repeatMode,
      shuffleMode: shuffleMode ?? this.shuffleMode,
    );
  }
}
