import 'package:fsm2/fsm2.dart';

import '../model/student.dart';

/// Base state for the student info FSM
abstract class StudentState extends State {
  @override
  String toString() => runtimeType.toString();
}

/// Initial state when no data has been loaded
class InitialState extends StudentState {}

/// State when data is being loaded
class LoadingState extends StudentState {}

/// State when data has been loaded successfully
class LoadedState extends StudentState {
  /// The list of students
  final List<Student> students;

  /// Constructor
  LoadedState(this.students);
}

/// State when an error occurred
class ErrorState extends StudentState {
  /// The error message
  final String errorMessage;

  /// Constructor
  ErrorState(this.errorMessage);
}
