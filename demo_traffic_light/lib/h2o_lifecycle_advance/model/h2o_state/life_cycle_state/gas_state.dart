part of '../h2o_state.dart';

/// Gas state (Steam)
class Gas extends H2OState {
  static int minStateTemperature = 101;
  static int maxStateTemperature = 1000;

  @override
  String get name => 'Gas';

  @override
  Color get color => Colors.grey.shade300;

  @override
  IconData get stateIcon => Icons.cloud;

  @override
  String get stateDescription => 'Steam (H₂O in gaseous state)';

  @override
  int get minTemperature => minStateTemperature;

  @override
  int get maxTemperature => maxStateTemperature;

  @override
  bool get isHeatUpEnabled => false;

  @override
  bool get isFreezeEnabled => true;

  @override
  H2OState copyWith() => Gas();
}
