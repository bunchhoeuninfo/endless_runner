import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogUtil {
  static final Logger _logger = Logger();

  /// Logs debug messages in debug mode only.
  static void debug(String message) {
    if (kDebugMode) {
      _logger.d(message);
    }
  }

  /// Logs informational messages.
  static void info(String message) {
    _logger.i(message);
  }

  /// Logs warnings.
  static void warn(String message) {
    _logger.w(message);
  }

  /// Logs errors.
  static void error(String message, {dynamic error, StackTrace? stackTrace}) {
    final errorMessage = StringBuffer(message);
    if (error != null) errorMessage.write('\nError: $error');
    if (stackTrace != null) errorMessage.write('\nStackTrace: $stackTrace');

    _logger.e(errorMessage.toString());
  }
}