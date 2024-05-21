import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:varanasi/core/core.dart';

typedef TransformResponse<T, R> = R Function(T data);

class ApiClient {
  ApiClient._();

  static final ApiClient instance = ApiClient._();

  static final HttpClient _client =
      HttpClient(kDebugMode ? 'http://$ipAddress:8080/v1' : baseUrl);

  static HttpClient get client => _client;

  static Future<T?> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    TransformResponse<JSON, T>? transformResponse,
  }) async {
    final response = await _client.get<JSON>(
      path,
      queryParameters: queryParameters,
    );

    final data = response.data;

    if (data == null) {
      return null;
    }

    return transformResponse?.call(data) ?? data as T;
  }
}
