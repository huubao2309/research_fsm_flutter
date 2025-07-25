import 'package:fsm2/fsm2.dart';

import '../h20_state/h2o_state.dart';

/// Base class for all H2O state machine events
abstract class H2OEvent extends Event {
  H2OState get nextState;

  /// Human-readable description of the event
  String get description;
}

/// Event to melt ice (Solid -> Liquid)
class MeltEvent extends H2OEvent {
  @override
  String get description => 'Melting ice to water';

  @override
  H2OState get nextState => Liquid();
}

/// Event to freeze water (Liquid -> Solid)
class FreezeEvent extends H2OEvent {
  @override
  String get description => 'Freezing water to ice';

  @override
  H2OState get nextState => Solid();
}

/// Event to vaporize water (Liquid -> Gas)
class VaporizeEvent extends H2OEvent {
  @override
  String get description => 'Vaporizing water to steam';

  @override
  H2OState get nextState => Gas();
}

/// Event to condense steam (Gas -> Liquid)
class CondenseEvent extends H2OEvent {
  @override
  String get description => 'Condensing steam to water';

  @override
  H2OState get nextState => Liquid();
}
