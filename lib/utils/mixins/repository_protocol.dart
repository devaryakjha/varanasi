import 'dart:async';

import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/utils/services/http_services.dart';

/// this mixin contains standard protocols for repository
/// e.g. get
mixin DataProviderProtocol {
  HttpService get httpService => HttpService();

  @mustCallSuper
  FutureOr<(dynamic, T?)> fetch<T>(
    String url, {
    CommonOptions<T>? options,
    Map<String, dynamic>? queryParameters,
  }) =>
      httpService.get<T>(url, options, queryParameters);

  @mustCallSuper
  FutureOr<(dynamic, T?)> fetchUri<T>(
    Uri uri, {
    CommonOptions<T>? options,
  }) =>
      httpService.get<T>('', options, null, uri);
}
