part of '../h2o_state.dart';

/// Gas state (Steam)
class Gas extends H2OState {
  @override
  String get name => 'Gas';

  @override
  Color get color => Colors.lightBlue.shade50;

  @override
  int get transitionDurationInSeconds => 7; // For condensing

  @override
  String get stateDescription => 'Steam (H₂O in gaseous state)';

  @override
  String get stateTemperature => 'Temperature: > 100°C';

  @override
  IconData get stateIcon => Icons.cloud;

  @override
  String get negativeButtonText => '';

  @override
  String get positiveButtonText => 'Do Condense';

  @override
  bool get showNegativeButton => false;

  @override
  bool get showPositiveButton => true;

  @override
  H2OState copyWith() => Gas();

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Gas && runtimeType == other.runtimeType;

  @override
  int get hashCode => 2;
}
