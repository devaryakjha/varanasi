import 'dart:async';

import 'package:dio/dio.dart';
import 'package:varanasi_mobile_app/utils/configs.dart';
import 'package:varanasi_mobile_app/utils/exceptions/network_exception.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';

typedef ResponseTransformer<T> = FutureOr<T> Function(dynamic response);

class CommonOptions<T> {
  final ResponseTransformer<T>? transformer;
  final Options? options;

  CommonOptions({this.transformer, this.options});
}

class HttpService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: appConfig.server.baseUrl,
    headers: {
      'Content-Type': 'application/json',
      'Cookie': 'L=english; DL=english;',
    },
  ));

  FutureOr<(dynamic, T?)> get<T>(
    String url, [
    CommonOptions<T>? options,
    Map<String, dynamic>? queryParameters,
    Uri? uri,
  ]) async {
    assert(
      !(queryParameters != null && uri != null),
      'Cannot provide both queryParameters and uri',
    );
    try {
      Response response;
      if (uri != null) {
        response = await dio.getUri(uri);
      } else {
        response = await dio.get(
          url,
          queryParameters: queryParameters,
          options: options?.options,
        );
      }
      if (options?.transformer != null) {
        final transformed = await options!.transformer!(response.data['data']);
        return (response.data, transformed);
      }
      return (response.data, null);
    } on DioException catch (e) {
      throw NetworkException(
        forUrl: uri?.toString() ?? url,
        error: e.message ?? 'Unknown error occurred',
        statusCode: e.response?.statusCode ?? 500,
      );
    } on Exception catch (e, stackTrace) {
      Logger.instance.e(
        'Error while fetching data from $url',
        error: e,
        stackTrace: stackTrace,
      );
      return (null, null);
    }
  }

  FutureOr<Response<T>> post<T>(String url, dynamic data) async {
    return await dio.post<T>(url, data: data);
  }

  FutureOr<Response<T>> put<T>(String url, dynamic data) async {
    return await dio.put<T>(url, data: data);
  }

  FutureOr<Response<T>> delete<T>(String url) async {
    return await dio.delete<T>(url);
  }
}
