import 'package:fsm2/fsm2.dart';

/// Base event for the student info FSM
abstract class StudentEvent extends Event {}

/// Event to fetch student data
class FetchStudentsEvent extends StudentEvent {}

/// Event when student data is loaded successfully
class StudentsLoadedEvent extends StudentEvent {}

/// Event when an error occurs
class ErrorEvent extends StudentEvent {}
