import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:trivia_guru/config/app_config.dart';

class LoggingUtils {
  static late Logger log;
  static initLogging() {
    if (AppConfig.writeLog) {
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
    if (AppConfig.writeLog) {
      log.fine(message);
    }
  }
}
