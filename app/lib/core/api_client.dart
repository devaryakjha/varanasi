import 'package:dio/dio.dart';
import 'package:varanasi/core/types.dart';

typedef TransformResponse<T, R> = R Function(T data);

class ApiClient {
  ApiClient._();

  static final ApiClient instance = ApiClient._();

  static final Dio _dio =
      // TODO(Arya): make the base url configurable
      Dio(BaseOptions(baseUrl: 'http://192.168.31.130:8080/v1'));

  static Dio get dio => _dio;

  static Future<T?> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    TransformResponse<JSON, T>? transformResponse,
  }) async {
    final response =
        await _dio.get<JSON>(path, queryParameters: queryParameters);

    final data = response.data;

    if (data == null) {
      return null;
    }

    return transformResponse?.call(data) ?? data as T;
  }
}
