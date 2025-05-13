part of '../h2o_state.dart';

/// Solid state (Ice)
class Solid extends H2OState {
  @override
  String get name => 'Solid';

  @override
  Color get color => Colors.blue.shade100;

  @override
  int get transitionDurationInSeconds => 5;

  @override
  String get stateDescription => 'Ice (H₂O in solid state)';

  @override
  String get stateTemperature => 'Temperature: < 0°C';

  @override
  IconData get stateIcon => Icons.ac_unit;

  @override
  String get negativeButtonText => 'Do Melted';

  @override
  String get positiveButtonText => '';

  @override
  bool get showNegativeButton => true;

  @override
  bool get showPositiveButton => false;

  @override
  H2OState copyWith() => Solid();

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Solid && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
