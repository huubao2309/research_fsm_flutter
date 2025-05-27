import 'package:fsm2/fsm2.dart';

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
class LoadedState extends StudentState {}

/// State when an error occurred
class ErrorState extends StudentState {}
