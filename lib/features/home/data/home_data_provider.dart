import 'package:varanasi_mobile_app/utils/configs.dart';
import 'package:varanasi_mobile_app/utils/mixins/repository_protocol.dart';
import 'package:varanasi_mobile_app/utils/services/http_services.dart';

import 'models/home_page_data.dart';

class HomeDataProvider with DataProviderProtocol {
  HomeDataProvider._();
  static final instance = HomeDataProvider._();

  Future<(dynamic, HomePageData?)> fetchModules() async {
    final response = await fetch(
      appConfig.endpoint.modules,
      options: CommonOptions(transformer: parseModules),
    );
    return response;
  }

  HomePageData? parseModules(dynamic data) {
    return HomePageData.fromJson(Map<String, dynamic>.from(data));
  }
}
