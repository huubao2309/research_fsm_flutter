part of '../h2o_state.dart';

/// Gas state (Steam)
class Gas extends H2OState {
  @override
  String get name => 'Gas';

  @override
  Color get color => Colors.grey.shade300;

  @override
  IconData get stateIcon => Icons.cloud;

  @override
  String get stateDescription => 'Steam (H₂O in gaseous state)';

  @override
  int get minTemperature => 101;

  @override
  int get maxTemperature => 1000;

  @override
  bool get isHeatUpEnabled => false;

  @override
  bool get isFreezeEnabled => true;

  @override
  H2OState copyWith() => Gas();
}
