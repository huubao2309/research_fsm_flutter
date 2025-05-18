part of '../h2o_state.dart';

/// Liquid state (Water)
class Liquid extends H2OState {
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
  int get minTemperature => 1;

  @override
  int get maxTemperature => 100;

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
