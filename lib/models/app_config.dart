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
  final DownloadQuality? streamingQuality;
  @HiveField(5, defaultValue: false)
  final bool isAdvancedModeEnabled;
  @HiveField(6)
  final DownloadQuality? downloadingQuality;

  AppConfig({
    this.sortBy = SortBy.custom,
    this.repeatMode = 0,
    this.colorScheme = 41,
    this.isDataSaverEnabled = false,
    this.streamingQuality,
    this.isAdvancedModeEnabled = false,
    this.downloadingQuality,
  });

  AppConfig copyWith({
    SortBy? sortBy,
    int? repeatMode,
    int? colorScheme,
    bool? isDataSaverEnabled,
    DownloadQuality? streamingQuality,
    bool? isAdvancedModeEnabled,
    DownloadQuality? downloadingQuality,
  }) {
    return AppConfig(
      sortBy: sortBy ?? this.sortBy,
      repeatMode: repeatMode ?? this.repeatMode,
      colorScheme: colorScheme ?? this.colorScheme,
      isDataSaverEnabled: isDataSaverEnabled ?? this.isDataSaverEnabled,
      streamingQuality: streamingQuality ?? this.streamingQuality,
      isAdvancedModeEnabled:
          isAdvancedModeEnabled ?? this.isAdvancedModeEnabled,
      downloadingQuality: downloadingQuality ?? this.downloadingQuality,
    );
  }

  @override
  List<Object?> get props => [
        sortBy,
        repeatMode,
        colorScheme,
        isDataSaverEnabled,
        streamingQuality,
        isAdvancedModeEnabled,
        downloadingQuality,
      ];

  @override
  bool get stringify => true;

  FlexScheme get scheme => FlexScheme.values[colorScheme];

  static Box<AppConfig> get getBox =>
      Hive.box<AppConfig>(AppStrings.configBoxName);

  static Future<Box<AppConfig>> openBox() =>
      Hive.openBox<AppConfig>(AppStrings.configBoxName);

  static DownloadQuality? get effectiveDlQuality =>
      getBox.get(0)?.downloadingQuality;

  static set effectiveDlQuality(DownloadQuality? quality) => getBox.put(
        0,
        getBox.get(0)?.copyWith(downloadingQuality: quality) ??
            AppConfig(downloadingQuality: quality),
      );

  static set effectivestreaQuality(DownloadQuality? quality) => getBox.put(
        0,
        getBox.get(0)?.copyWith(streamingQuality: quality) ??
            AppConfig(streamingQuality: quality),
      );
}
