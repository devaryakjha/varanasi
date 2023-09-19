import 'package:hive/hive.dart';

part 'sort_type.g.dart';

/// Enum for sorting the media items in the library.
@HiveType(typeId: 14)
enum SortBy {
  @HiveField(0)
  custom,
  @HiveField(1)
  title,
  // artist,
  // album,
  // recentlyAdded,
}
