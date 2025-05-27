import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:demo_traffic_light/student_infos/model/student.dart';
import 'package:demo_traffic_light/student_infos/state/student_events.dart';
import 'package:demo_traffic_light/student_infos/state/student_state_machine.dart';
import 'package:demo_traffic_light/student_infos/state/student_states.dart';

void main() {
  late StudentStateMachine stateMachine;

  setUp(() {
    stateMachine = StudentStateMachine();
  });

  group('StudentStateMachine', () {
    test('should initialize with InitialState', () {
      expect(stateMachine.currentState, isA<InitialState>());
    });

    test('should transition to LoadingState on FetchStudentsEvent', () async {
      // Arrange
      final completer = SafeCompleter<StudentState>();

      stateMachine.addListener((state) {
        if (state is LoadingState) {
          completer.complete(state);
        }
      });

      // Act
      stateMachine.applyEvent(FetchStudentsEvent());

      // Wait for the state change
      final newState = await completer.future.timeout(
        const Duration(seconds: 1),
        onTimeout: () => stateMachine.currentState,
      );

      // Assert
      expect(newState, isA<LoadingState>());
      expect(stateMachine.currentState, isA<LoadingState>());
    });

    test('should transition to LoadedState on StudentsLoadedEvent', () async {
      // Arrange
      final students = [
        Student(id: 1, name: 'Test Student', age: 20, phoneNumber: '1234567890'),
      ];

      final loadingCompleter = SafeCompleter<StudentState>();
      final loadedCompleter = SafeCompleter<StudentState>();

      stateMachine.addListener((state) {
        if (state is LoadingState && !loadingCompleter.isCompleted) {
          loadingCompleter.complete(state);
        } else if (state is LoadedState && !loadedCompleter.isCompleted) {
          loadedCompleter.complete(state);
        }
      });

      // First transition to LoadingState
      stateMachine.applyEvent(FetchStudentsEvent());

      // Wait for the loading state
      await loadingCompleter.future.timeout(
        const Duration(seconds: 1),
        onTimeout: () => stateMachine.currentState,
      );

      // Act
      stateMachine.applyEvent(StudentsLoadedEvent(students));

      // Wait for the loaded state
      final newState = await loadedCompleter.future.timeout(
        const Duration(seconds: 1),
        onTimeout: () => stateMachine.currentState,
      );

      // Assert
      expect(newState, isA<LoadedState>());
      expect(stateMachine.currentState, isA<LoadedState>());
      expect((stateMachine.currentState as LoadedState).students, equals(students));
    });

    test('should transition to ErrorState on ErrorEvent', () async {
      // Arrange
      const errorMessage = 'Test error';

      final loadingCompleter = SafeCompleter<StudentState>();
      final errorCompleter = SafeCompleter<StudentState>();

      stateMachine.addListener((state) {
        if (state is LoadingState && !loadingCompleter.isCompleted) {
          loadingCompleter.complete(state);
        } else if (state is ErrorState && !errorCompleter.isCompleted) {
          errorCompleter.complete(state);
        }
      });

      // First transition to LoadingState
      stateMachine.applyEvent(FetchStudentsEvent());

      // Wait for the loading state
      await loadingCompleter.future.timeout(
        const Duration(seconds: 1),
        onTimeout: () => stateMachine.currentState,
      );

      // Act
      stateMachine.applyEvent(ErrorEvent(errorMessage));

      // Wait for the error state
      final newState = await errorCompleter.future.timeout(
        const Duration(seconds: 1),
        onTimeout: () => stateMachine.currentState,
      );

      // Assert
      expect(newState, isA<ErrorState>());
      expect(stateMachine.currentState, isA<ErrorState>());
      expect((stateMachine.currentState as ErrorState).errorMessage, equals(errorMessage));
    });
  });
}

// Helper class for tests
class SafeCompleter<T> {
  bool _isCompleted = false;
  final _completer = Completer<T>();

  bool get isCompleted => _isCompleted;

  Future<T> get future => _completer.future;

  void complete(T value) {
    if (!_isCompleted) {
      _isCompleted = true;
      _completer.complete(value);
    }
  }
}
