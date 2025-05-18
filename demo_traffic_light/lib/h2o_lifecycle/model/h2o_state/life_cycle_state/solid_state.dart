part of '../h2o_state.dart';

/// Solid state (Ice)
class Solid extends H2OState {
  static int minStateTemperature = -1000;
  static int maxStateTemperature = 0;

  @override
  String get name => 'Solid';

  @override
  Color get color => Colors.blue.shade100;

  @override
  IconData get stateIcon => Icons.ac_unit;

  @override
  String get stateDescription => 'Ice (H₂O in solid state)';

  @override
  int get minTemperature => minStateTemperature;

  @override
  int get maxTemperature => maxStateTemperature;

  @override
  bool get isHeatUpEnabled => true;

  @override
  bool get isFreezeEnabled => false;

  @override
  H2OState copyWith() => Solid();
}
