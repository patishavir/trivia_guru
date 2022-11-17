import 'package:logging/logging.dart';

class LoggingUtils {
  static var log = Logger('ExampleLogger');
  static initLogging() {
    Logger.root.level = Level.FINE; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  static void writeLog(String message) {
    log.fine(message);
  }
}
