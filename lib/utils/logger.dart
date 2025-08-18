
import 'dart:developer' as developer;

class AppLogger {
  static void debug(String message) {
    developer.log(message, name: 'DEBUG');
  }

  static void info(String message) {
    developer.log(message, name: 'INFO');
  }

  static void warning(String message) {
    developer.log(message, name: 'WARNING');
  }

  static void error(String message) {
    developer.log(message, name: 'ERROR');
  }
}