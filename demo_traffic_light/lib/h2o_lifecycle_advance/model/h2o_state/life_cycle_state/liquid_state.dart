part of '../h2o_state.dart';

/// Liquid state (Water)
class Liquid extends H2OState {
  static int minStateTemperature = 1;
  static int maxStateTemperature = 100;

  /// Direction of transition (from Solid or from Gas)
  final TransitionDirection direction;

  /// Constructor
  Liquid({required this.direction});

  @override
  String get name => 'Liquid';

  @override
  Color get color => Colors.blue;

  @override
  IconData get stateIcon => Icons.water_drop;

  @override
  String get stateDescription => 'Water (H₂O in liquid state)';

  @override
  int get minTemperature => minStateTemperature;

  @override
  int get maxTemperature => maxStateTemperature;

  @override
  bool get isHeatUpEnabled => direction == TransitionDirection.fromSolid ? false : true;

  @override
  bool get isFreezeEnabled => direction == TransitionDirection.fromSolid ? true : false;

  @override
  H2OState copyWith() => Liquid(direction: direction);
}

/// Enum to track the direction of transition for Liquid state
enum TransitionDirection {
  /// Transitioning from Solid to Liquid
  fromSolid,

  /// Transitioning from Gas to Liquid
  fromGas
}
