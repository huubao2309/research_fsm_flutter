import 'package:flutter/foundation.dart';
import 'package:fsm2/fsm2.dart';

import 'log_utils.dart';

class LogUtilsImpl extends LogUtils {
  /// Log state lifecycle events
  @override
  void logStateLifecycle(String message) {
    if (kDebugMode) {
      print("Lifecycle: $message");
    }
  }

  /// Log update state
  @override
  void logUpdateState(String message) {
    if (kDebugMode) {
      print("Update State: $message");
    }
  }

  /// Log state transitions
  @override
  void logTransition(StateDefinition<State>? previous, Event? event, StateDefinition<State>? current) {
    if (kDebugMode) {
      print("Transition: ${previous?.stateType} --[${event?.runtimeType}]--> ${current?.stateType}");
    }
  }
}
