// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:varanasi_mobile_app/models/download_url.dart';
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
  @HiveField(3, defaultValue: false)
  final bool isDataSaverEnabled;
  @HiveField(4)
  final DownloadQuality? downloadQuality;
  @HiveField(5, defaultValue: false)
  final bool isAdvancedModeEnabled;

  AppConfig({
    this.sortBy = SortBy.custom,
    this.repeatMode = 0,
    this.colorScheme = 41,
    this.isDataSaverEnabled = false,
    this.downloadQuality,
    this.isAdvancedModeEnabled = false,
  });

  AppConfig copyWith({
    SortBy? sortBy,
    int? repeatMode,
    int? colorScheme,
    bool? isDataSaverEnabled,
    DownloadQuality? downloadQuality,
    bool? isAdvancedModeEnabled,
  }) {
    return AppConfig(
      sortBy: sortBy ?? this.sortBy,
      repeatMode: repeatMode ?? this.repeatMode,
      colorScheme: colorScheme ?? this.colorScheme,
      isDataSaverEnabled: isDataSaverEnabled ?? this.isDataSaverEnabled,
      downloadQuality: downloadQuality ?? this.downloadQuality,
      isAdvancedModeEnabled:
          isAdvancedModeEnabled ?? this.isAdvancedModeEnabled,
    );
  }

  @override
  List<Object?> get props => [
        sortBy,
        repeatMode,
        colorScheme,
        isDataSaverEnabled,
        downloadQuality,
        isAdvancedModeEnabled,
      ];

  @override
  bool get stringify => true;

  FlexScheme get scheme => FlexScheme.values[colorScheme];

  static Box<AppConfig> get getBox =>
      Hive.box<AppConfig>(AppStrings.configBoxName);

  static Future<Box<AppConfig>> openBox() =>
      Hive.openBox<AppConfig>(AppStrings.configBoxName);
}
