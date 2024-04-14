import 'dart:developer';

import 'package:logging/logging.dart';

late final Logger _logger;

/// Initializes the logger with the given [appName].
Logger initLogger(String appName) {
  _logger = Logger(appName);
  _logger.onRecord.listen((record) {
    log(
      record.message,
      time: record.time,
      zone: record.zone,
      stackTrace: record.stackTrace,
      error: record.error,
      name: record.loggerName,
      level: record.level.value,
    );
  });
  return _logger;
}

/// Logs an info message.
void logInfo(String message) {
  _logger.info(message);
}

/// Logs a warning message.
void logWarning(String message) {
  _logger.warning(message);
}

/// Logs an error message.
void logError(String message, Object? error, StackTrace? stackTrace) {
  _logger.severe(message, error, stackTrace);
}

/// Logs a debug message.
void logDebug(String message) {
  _logger.finest(message);
}
