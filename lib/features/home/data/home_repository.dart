import 'dart:async';

import 'package:hive/hive.dart';
import 'package:varanasi_mobile_app/utils/configs.dart';
import 'package:varanasi_mobile_app/utils/constants/strings.dart';
import 'package:varanasi_mobile_app/utils/mixins/cachable_mixin.dart';

import 'home_data_provider.dart';
import 'models/home_page_data.dart';

class HomeRepository with CacheableService {
  late final Box _box;

  HomeRepository._();

  static final instance = HomeRepository._();

  @override
  String get cacheBoxName => AppStrings.commonCacheBoxName;

  @override
  Box get box => _box;

  Future<HomePageData?> fetchModules() async {
    await initcache().then((value) {
      if (value == null) return;
      _box = value;
    });
    final cachedData = isCached(appConfig.endpoint.modules);
    if (cachedData != null) {
      final parsed = HomeDataProvider.instance.parseModules(cachedData['data']);
      return parsed;
    }
    final (response, parsed) = await HomeDataProvider.instance.fetchModules();
    cache(appConfig.endpoint.modules, response);
    return parsed;
  }
}
