import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

typedef ResponseTransformer<T> = T Function(dynamic response);

class CommonOptions<T> {
  final ResponseTransformer<T>? transformer;
  final Options? options;

  CommonOptions({this.transformer, this.options});
}

class HttpService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: kDebugMode ? "http://localhost:3000" : "https://saavn.aryak.dev",
    headers: {
      'Content-Type': 'application/json',
      'Cookie': 'L=english; DL=english;',
    },
  ));

  FutureOr<(dynamic, T?)> get<T>(
    String url, [
    CommonOptions<T>? options,
    Map<String, dynamic>? queryParameters,
  ]) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options?.options,
      );
      if (options?.transformer != null) {
        return (response.data, options!.transformer!(response.data['data']));
      }
      return (response.data, null);
    } on Exception {
      // Logger.e('Error while fetching data from $url', e, stackTrace);
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
