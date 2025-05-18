import 'package:flutter/material.dart';
import 'package:fsm2/fsm2.dart' as fsm2;

part 'life_cycle_state/solid_state.dart';
part 'life_cycle_state/liquid_state.dart';
part 'life_cycle_state/gas_state.dart';

/// Base class for H2O states in the advanced lifecycle demo
abstract class H2OState extends fsm2.State {
  /// Name of the state
  String get name;
  
  /// Color representing the state
  Color get color;
  
  /// Icon representing the state
  IconData get stateIcon;
  
  /// Description of the state
  String get stateDescription;
  
  /// Minimum temperature for this state in Celsius
  int get minTemperature;
  
  /// Maximum temperature for this state in Celsius
  int get maxTemperature;
  
  /// Whether the heat up button should be enabled
  bool get isHeatUpEnabled;
  
  /// Whether the freeze button should be enabled
  bool get isFreezeEnabled;
  
  /// Create a copy of this state
  H2OState copyWith();
  
  @override
  String toString() => name;
}
