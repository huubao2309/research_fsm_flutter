import 'package:fsm2/fsm2.dart' as fms2;

/// Base class for traffic light states
abstract class TrafficLightStateBase extends fms2.State {}

/// Green state
class GreenState extends TrafficLightStateBase {}

/// Yellow state
class YellowState extends TrafficLightStateBase {}

/// Red state
class RedState extends TrafficLightStateBase {}
