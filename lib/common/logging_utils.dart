import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class LoggingUtils {
  static Logger? _log;

  static _initLogging() {
    if (kDebugMode) {
      _log = Logger('Flutter logger');
      Logger.root.level = Level.FINE; // defaults to Level.INFO
      Logger.root.onRecord.listen((record) {
        if (kDebugMode) {
          print('${record.level.name}: ${record.time}: ${record.message}');
        }
      });
    }
  }

  static void writeLog(String? message) {
    if (kDebugMode) {
      if (_log == null) {
        _initLogging();
      }
      _log?.fine(message);
    }
  }
}
