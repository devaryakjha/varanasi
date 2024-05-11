import 'dart:convert';
import 'dart:io' as io;

final class Response<T> {
  const Response({
    required this.raw,
    required this.statusCode,
    this.data,
  });

  final String raw;
  final int statusCode;
  final T? data;
}

final class HttpClient {
  HttpClient(this.baseUrl) : _baseClient = io.HttpClient();

  final io.HttpClient _baseClient;

  final String baseUrl;

  Uri get baseUri => Uri.parse(baseUrl);

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = baseUri.replace(
      queryParameters: queryParameters,
    );
    final request = await _baseClient.getUrl(uri);
    final res = await request.close();
    final raw = await res.transform(utf8.decoder).join();
    final response = Response<T>(
      raw: raw,
      statusCode: res.statusCode,
      data: jsonDecode(raw) as T?,
    );
    return response;
  }
}
