// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:varanasi_mobile_app/utils/constants/constants.dart';

import 'sort_type.dart';

part 'app_config.g.dart';

@HiveType(typeId: 13)
class AppConfig extends HiveObject with EquatableMixin {
  @HiveField(0, defaultValue: SortBy.custom)
  final SortBy sortBy;
  @HiveField(1, defaultValue: 0)
  final int repeatMode;
  @HiveField(2, defaultValue: 41)
  final int colorScheme;

  AppConfig({
    this.sortBy = SortBy.custom,
    this.repeatMode = 0,
    this.colorScheme = 41,
  });

  AppConfig copyWith({
    SortBy? sortBy,
    int? repeatMode,
    int? colorScheme,
  }) {
    return AppConfig(
      sortBy: sortBy ?? this.sortBy,
      repeatMode: repeatMode ?? this.repeatMode,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }

  @override
  List<Object?> get props => [sortBy, repeatMode, colorScheme];

  @override
  bool get stringify => true;

  FlexScheme get scheme => FlexScheme.values[colorScheme];

  static Box<AppConfig> get getBox =>
      Hive.box<AppConfig>(AppStrings.configBoxName);

  static Future<Box<AppConfig>> openBox() =>
      Hive.openBox<AppConfig>(AppStrings.configBoxName);
}
