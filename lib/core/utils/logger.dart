import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

class SirajiLogger {
  SirajiLogger._();

  static void debug(String message, {String? tag}) =>
      _log(LogLevel.debug, message, tag: tag);

  static void info(String message, {String? tag}) =>
      _log(LogLevel.info, message, tag: tag);

  static void warning(String message, {String? tag}) =>
      _log(LogLevel.warning, message, tag: tag);

  static void error(String message, {String? tag, Object? exception}) {
    _log(LogLevel.error, message, tag: tag);
    if (exception != null && kDebugMode) {
      debugPrint('[SIRAJI][ERROR] Exception: $exception');
    }
  }

  static void _log(LogLevel level, String message, {String? tag}) {
    if (!kDebugMode) return;
    final prefix = switch (level) {
      LogLevel.debug => 'DEBUG',
      LogLevel.info => 'INFO',
      LogLevel.warning => 'WARN',
      LogLevel.error => 'ERROR',
    };
    final tagStr = tag != null ? '[$tag]' : '';
    debugPrint('[SIRAJI][$prefix]$tagStr $message');
  }
}
