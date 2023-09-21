import 'dart:async';

import 'package:hive/hive.dart';
import 'package:varanasi_mobile_app/utils/configs.dart';
import 'package:varanasi_mobile_app/utils/constants/strings.dart';
import 'package:varanasi_mobile_app/utils/exceptions/app_exception.dart';
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

  Future<HomePageData?> fetchModules({bool ignoreCache = false}) async {
    try {
      await initcache().then((value) {
        if (value == null) return;
        _box = value;
      });
      if (!ignoreCache) {
        final cachedData =
            maybeGetCached<HomePageData>(appConfig.endpoint.modules);
        if (cachedData != null) return cachedData;
      }
      final (_, parsed) = await HomeDataProvider.instance.fetchModules();
      if (parsed != null) {
        cache(appConfig.endpoint.modules, parsed, const Duration(hours: 4));
      }
      return parsed;
    } on AppException {
      rethrow;
    }
  }
}
