import 'dart:async';

import 'package:fsm2/fsm2.dart';
import 'package:flutter/foundation.dart';

/// A generic base class for all state machines using fsm2
abstract class BaseStateMachine<S extends State> {
  /// The internal state machine from fsm2
  late StateMachine _stateMachine;
  
  /// Stream controller for state changes
  final _stateController = StreamController<S>.broadcast();
  
  /// Stream of state changes that UI components can listen to
  Stream<S> get stateChanges => _stateController.stream;
  
  /// The current state of the state machine
  S get currentState;
  
  /// Initialize the state machine
  @protected
  Future<void> initialize() async {
    _stateMachine = await createStateMachine();
    _logStateInitialized();
  }
  
  /// Create the state machine with all transitions
  @protected
  Future<StateMachine> createStateMachine();
  
  /// Apply an event to the state machine
  void applyEvent<E extends Event>(E event) {
    try {
      _stateMachine.applyEvent(event);
    } catch (e) {
      _logError('Error applying event $event: $e');
      rethrow;
    }
  }
  
  /// Notify listeners of a state change
  @protected
  void notifyStateChanged(S newState) {
    if (!_stateController.isClosed) {
      _stateController.add(newState);
    }
  }
  
  /// Log state machine initialization
  void _logStateInitialized() {
    if (kDebugMode) {
      print('State machine initialized with state: ${currentState.runtimeType}');
    }
  }
  
  /// Log errors
  void _logError(String message) {
    if (kDebugMode) {
      print('ERROR: $message');
    }
  }
  
  /// Dispose resources
  void dispose() {
    _stateController.close();
  }
}
