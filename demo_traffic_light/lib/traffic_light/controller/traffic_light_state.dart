import 'package:flutter/material.dart';
import 'package:fsm2/fsm2.dart' as fms2;

/// Base class for traffic light states
abstract class TrafficLightStateBase extends fms2.State {
  abstract final String name;
  abstract final Color color;
  abstract final int durationInSeconds;
}

/// Green state
class GreenState extends TrafficLightStateBase {
  @override
  Color get color => Colors.green;

  @override
  int get durationInSeconds => 5;

  @override
  String get name => 'Green';
}

/// Yellow state
class YellowState extends TrafficLightStateBase {
  @override
  Color get color => Colors.yellow;

  @override
  int get durationInSeconds => 2;

  @override
  String get name => 'Yellow';
}

/// Red state
class RedState extends TrafficLightStateBase {
  @override
  Color get color => Colors.red;

  @override
  int get durationInSeconds => 7;

  @override
  String get name => 'Red';
}
