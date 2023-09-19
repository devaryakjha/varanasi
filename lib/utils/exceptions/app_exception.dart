abstract class AppException implements Exception {
  /// The error message
  final String message;

  /// The prefix for the error message
  final String prefix;

  const AppException({required this.message, required this.prefix});

  @override
  String toString() => "$prefix$message";
}
