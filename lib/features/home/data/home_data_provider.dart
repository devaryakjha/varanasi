import 'package:varanasi_mobile_app/utils/configs.dart';
import 'package:varanasi_mobile_app/utils/mixins/repository_protocol.dart';
import 'package:varanasi_mobile_app/utils/services/http_services.dart';

import 'models/home_page_data.dart';

class HomeDataProvider with DataProviderProtocol {
  HomeDataProvider._();
  static final instance = HomeDataProvider._();

  Future<(dynamic, ModulesResponse?)> fetchModules() async {
    final response = await fetch(
      appConfig.endpoint.modules,
      options: CommonOptions(transformer: parseModules),
    );
    return response;
  }

  ModulesResponse? parseModules(dynamic data) {
    return ModulesResponse.fromJson(Map<String, dynamic>.from(data));
  }
}
