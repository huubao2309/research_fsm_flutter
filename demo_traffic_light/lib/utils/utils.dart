import 'package:flutter/foundation.dart';

/// Utility functions for the traffic light demo
class Utils {
  /// Log a message in debug mode
  static void log(String message) {
    if (kDebugMode) {
      print(message);
    }
  }


}
