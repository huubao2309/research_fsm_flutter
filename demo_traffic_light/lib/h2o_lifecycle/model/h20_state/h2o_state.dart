import 'package:flutter/material.dart';
import 'package:fsm2/fsm2.dart' as fsm2;

part 'life_cycle_state/solid_state.dart';
part 'life_cycle_state/liquid_state.dart';
part 'life_cycle_state/gas_state.dart';

/// Base class for H2O states
abstract class H2OState extends fsm2.State {
  /// Name of the state
  String get name;
  
  /// Color representing the state
  Color get color;
  
  /// Duration in seconds for transitioning from this state
  int get transitionDurationInSeconds;
  
  /// Description of the state
  String get stateDescription;

  /// Temperature of the state
  String get stateTemperature;
  
  /// Icon representing the state
  IconData get stateIcon;
  
  /// Button text for negative action
  String get negativeButtonText;
  
  /// Button text for positive action
  String get positiveButtonText;
  
  /// Whether the negative button should be visible
  bool get showNegativeButton;
  
  /// Whether the positive button should be visible
  bool get showPositiveButton;
  
  /// Create a copy of this state with optional property overrides
  H2OState copyWith();
}


