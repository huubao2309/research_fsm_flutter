import 'package:fsm2/fsm2.dart';

import '../model/student.dart';

/// Base event for the student info FSM
abstract class StudentEvent extends Event {}

/// Event to fetch student data
class FetchStudentsEvent extends StudentEvent {}

/// Event when student data is loaded successfully
class StudentsLoadedEvent extends StudentEvent {
  /// The list of students
  final List<Student> students;

  /// Constructor
  StudentsLoadedEvent(this.students);
}

/// Event when an error occurs
class ErrorEvent extends StudentEvent {
  /// The error message
  final String errorMessage;

  /// Constructor
  ErrorEvent(this.errorMessage);
}
