import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/api_response.dart';
import '../model/student.dart';
import '../repository/student_repository.dart';
import '../state/student_events.dart';
import '../state/student_state_machine.dart';
import '../state/student_states.dart';

/// Controller for the student info screen
class StudentController extends ChangeNotifier {
  /// The student repository
  final StudentRepository _repository;

  /// The state machine
  final StudentStateMachine _stateMachine;

  /// Constructor
  StudentController({
    StudentRepository? repository,
    StudentStateMachine? stateMachine,
  })  : _repository = repository ?? StudentRepository(),
        _stateMachine = stateMachine ?? StudentStateMachine() {
    // Listen for state changes
    _stateMachine.addListener(_onStateChanged);
  }

  /// Get the current state
  StudentState get currentState => _stateMachine.currentState;

  /// Check if the screen is in loading state
  bool get isLoading => currentState is LoadingState;

  /// Get the list of students (if available)
  List<Student>? get students {
    final StudentState state = currentState;
    if (state is LoadedState) {
      return state.students;
    }
    return null;
  }

  /// Fetch student data
  Future<void> fetchStudents() async {
    // Apply the fetch event to transition to loading state
    _stateMachine.applyEvent(FetchStudentsEvent());

    // Call the repository
    final ApiResponse<List<Student>> response = await _repository.getStudents();

    if (response.isSuccess && response.data != null) {
      // Success - transition to loaded state
      _stateMachine.applyEvent(StudentsLoadedEvent(response.data!));
      return;
    }

    // Error - transition to error state
    _stateMachine.applyEvent(ErrorEvent(
      response.errorMessage ?? 'Unknown error',
    ));
  }

  /// Handle state changes
  void _onStateChanged(StudentState state) {
    _logStateChange(state);
    notifyListeners();
  }

  /// Log state changes
  void _logStateChange(StudentState state) {
    if (kDebugMode) {
      print('StudentController: State changed to $state');
    }
  }

  @override
  void dispose() {
    _stateMachine.removeListener(_onStateChanged);
    _stateMachine.dispose();
    super.dispose();
  }
}
