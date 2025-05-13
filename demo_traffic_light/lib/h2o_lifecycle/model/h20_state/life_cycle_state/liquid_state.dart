part of '../h2o_state.dart';


/// Liquid state (Water)
class Liquid extends H2OState {
  @override
  String get name => 'Liquid';

  @override
  Color get color => Colors.blue;

  @override
  int get transitionDurationInSeconds => 3; // For vaporizing

  /// Duration for freezing is different
  int get freezingDurationInSeconds => 4;

  @override
  String get stateDescription => 'Water (H₂O in liquid state)';

  @override
  String get stateTemperature => 'Temperature: 0°C to 100°C';

  @override
  IconData get stateIcon => Icons.water_drop;

  @override
  String get negativeButtonText => 'Do Vaporize';

  @override
  String get positiveButtonText => 'Do Froze';

  @override
  bool get showNegativeButton => true;

  @override
  bool get showPositiveButton => true;

  @override
  H2OState copyWith() => Liquid();

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Liquid && runtimeType == other.runtimeType;

  @override
  int get hashCode => 1;
}