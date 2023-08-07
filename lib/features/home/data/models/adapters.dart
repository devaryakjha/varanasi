import 'package:hive_flutter/adapters.dart';

import 'chart.dart';
import 'home_page_data.dart';
import 'trending.dart';

void registerHomePageTypeAdapters() {
  Hive.registerAdapter<Chart>(ChartAdapter());
  Hive.registerAdapter<ModulesResponse>(HomePageDataAdapter());
  Hive.registerAdapter<Trending>(TrendingAdapter());
}
