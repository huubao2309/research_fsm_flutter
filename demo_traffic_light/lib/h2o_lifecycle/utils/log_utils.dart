import 'package:fsm2/fsm2.dart';

abstract class LogUtils {
  /// Log state transitions
  void logTransition(StateDefinition<State>? previous, Event? event, StateDefinition<State>? current);

  /// Log state lifecycle events
  void logStateLifecycle(String message);

  /// Log state transitions
  void logStateTransition(String message) ;
}
