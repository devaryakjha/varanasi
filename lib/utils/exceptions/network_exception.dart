import 'app_exception.dart';

class NetworkException implements AppException {
  /// The url for which the exception occurred
  final String forUrl;

  /// The error message
  final String error;

  /// The status code of the response
  final int statusCode;

  /// A [NetworkException] for the given [forUrl], [error] and [statusCode].
  /// It is intended to be used to throw exceptions from the data layer
  /// for the UI layer to handle
  const NetworkException({
    required this.forUrl,
    required this.error,
    required this.statusCode,
  });

  @override
  String toString() {
    return 'NetworkException { forUrl: $forUrl, error: $error, statusCode: $statusCode }';
  }

  @override
  int get hashCode =>
      forUrl.hashCode ^
      error.hashCode ^
      statusCode.hashCode ^
      prefix.hashCode ^
      message.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NetworkException &&
        other.forUrl == forUrl &&
        other.error == error &&
        other.statusCode == statusCode &&
        other.prefix == prefix &&
        other.message == message;
  }

  @override
  String get prefix => 'NetworkException';

  @override
  String get message =>
      '{ forUrl: $forUrl, message: $error, statusCode: $statusCode }';
}
