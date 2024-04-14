import 'package:logging/logging.dart';

late final Logger logger;

/// Initializes the logger with the given [appName].
Logger initLogger(String appName) {
  return logger = Logger(appName);
}

/// Logs an info message.
void logInfo(String message) {
  logger.info(message);
}

/// Logs a warning message.
void logWarning(String message) {
  logger.warning(message);
}

/// Logs an error message.
void logError(String message, Object? error, StackTrace? stackTrace) {
  logger.severe(message, error, stackTrace);
}

/// Logs a debug message.
void logDebug(String message) {
  logger.finest(message);
}
