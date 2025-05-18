import 'package:fsm2/fsm2.dart';

import '../h2o_state/h2o_state.dart';

/// Base class for all H2O state machine events
abstract class H2OEvent extends Event {
  /// The next state after this event
  H2OState get nextState;

  /// Human-readable description of the event
  String get description;

  /// Current temperature in Celsius
  final int temperature;

  /// Constructor
  H2OEvent({required this.temperature});
}

/// Event to melt ice (Solid -> Liquid)
class MeltEvent extends H2OEvent {
  /// Constructor
  MeltEvent({required super.temperature});

  @override
  String get description => 'Melting ice to water';

  @override
  H2OState get nextState => Liquid(direction: TransitionDirection.fromSolid);
}

/// Event to freeze water (Liquid -> Solid)
class FreezeEvent extends H2OEvent {
  /// Constructor
  FreezeEvent({required super.temperature});

  @override
  String get description => 'Freezing water to ice';

  @override
  H2OState get nextState => Solid();
}

/// Event to vaporize water (Liquid -> Gas)
class VaporizeEvent extends H2OEvent {
  /// Constructor
  VaporizeEvent({required super.temperature});

  @override
  String get description => 'Vaporizing water to steam';

  @override
  H2OState get nextState => Gas();
}

/// Event to condense steam (Gas -> Liquid)
class CondenseEvent extends H2OEvent {
  /// Constructor
  CondenseEvent({required super.temperature});

  @override
  String get description => 'Condensing steam to water';

  @override
  H2OState get nextState => Liquid(direction: TransitionDirection.fromGas);
}
