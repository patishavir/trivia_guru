import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:trivia_guru/config/game_config.dart';

class LoggingUtils {
  static Logger? log;

  static _initLogging() {
    if (GameConfig.writeLog) {
      log = Logger('AppLogger');
      Logger.root.level = Level.FINE; // defaults to Level.INFO
      Logger.root.onRecord.listen((record) {
        if (kDebugMode) {
          //   print('${record.level.name}: ${record.time}: ${record.message}');
        }
      });
    }
  }

  static void writeLog(String message) {
    if (GameConfig.writeLog) {
      if (log == null) {
        _initLogging();
      }
      log?.fine(message);
    }
  }
}
