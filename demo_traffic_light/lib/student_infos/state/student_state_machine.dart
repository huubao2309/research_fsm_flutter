import 'package:flutter/foundation.dart';
import 'package:fsm2/fsm2.dart';

import 'student_events.dart';
import 'student_states.dart';

/// State machine for the student info screen
class StudentStateMachine {
  /// The internal state machine
  late StateMachine _stateMachine;

  /// The current state
  StudentState _currentState = InitialState();

  /// Get the current state
  StudentState get currentState => _currentState;

  /// State change listeners
  final List<Function(StudentState)> _listeners = [];

  /// Constructor
  StudentStateMachine() {
    _initializeStateMachine();
  }

  /// Initialize the state machine
  Future<void> _initializeStateMachine() async {
    _stateMachine = await StateMachine.create(
      (g) => g
        ..initialState<InitialState>()

        // Initial state transitions
        ..state<InitialState>(
          (b) => b
            ..on<FetchStudentsEvent, LoadingState>(
              sideEffect: (event) async {
                _logTransition('InitialState', 'FetchStudentsEvent', 'LoadingState');
                _updateState(LoadingState());
              },
            ),
        )

        // Loading state transitions
        ..state<LoadingState>(
          (b) => b
            ..on<StudentsLoadedEvent, LoadedState>(
              sideEffect: (event) async {
                _logTransition('LoadingState', 'StudentsLoadedEvent', 'LoadedState');
                _updateState(LoadedState(event.students));
              },
            )
            ..on<ErrorEvent, ErrorState>(
              sideEffect: (event) async {
                _logTransition('LoadingState', 'ErrorEvent', 'ErrorState');
                _updateState(ErrorState(event.errorMessage));
              },
            ),
        )

        // Loaded state transitions
        ..state<LoadedState>(
          (b) => b
            ..on<FetchStudentsEvent, LoadingState>(
              sideEffect: (event) async {
                _logTransition('LoadedState', 'FetchStudentsEvent', 'LoadingState');
                _updateState(LoadingState());
              },
            ),
        )

        // Error state transitions
        ..state<ErrorState>(
          (b) => b
            ..on<FetchStudentsEvent, LoadingState>(
              sideEffect: (event) async {
                _logTransition('ErrorState', 'FetchStudentsEvent', 'LoadingState');
                _updateState(LoadingState());
              },
            ),
        ),
    );
  }

  /// Apply an event to the state machine
  void applyEvent(StudentEvent event) {
    _stateMachine.applyEvent(event);
  }

  /// Update the current state and notify listeners
  void _updateState(StudentState newState) {
    _currentState = newState;
    _notifyListeners();
  }

  /// Add a listener for state changes
  void addListener(Function(StudentState) listener) {
    _listeners.add(listener);
  }

  /// Remove a listener
  void removeListener(Function(StudentState) listener) {
    _listeners.remove(listener);
  }

  /// Notify all listeners of a state change
  void _notifyListeners() {
    for (final listener in _listeners) {
      listener(_currentState);
    }
  }

  /// Log state transitions
  void _logTransition(String fromState, String event, String toState) {
    if (kDebugMode) {
      print('StudentStateMachine: $fromState --[$event]--> $toState');
    }
  }

  /// Log errors
  void _logError(String message) {
    if (kDebugMode) {
      print('StudentStateMachine ERROR: $message');
    }
  }

  /// Dispose the state machine
  void dispose() {
    _listeners.clear();
  }
}
