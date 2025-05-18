import 'package:demo_traffic_light/core/fsm/base_state_machine.dart';
import 'package:demo_traffic_light/h2o_lifecycle/model/events/h2o_events.dart';
import 'package:demo_traffic_light/h2o_lifecycle/model/h2o_state/h2o_state.dart';
import 'package:flutter/foundation.dart';
import 'package:fsm2/fsm2.dart';

/// State machine for H2O lifecycle advanced demo
class H2OStateMachine extends BaseStateMachine<H2OState> {
  /// The current state of the state machine
  H2OState _currentState = Solid();

  /// Get the current state
  @override
  H2OState get currentState => _currentState;

  /// Initialize the state machine
  Future<void> init() async {
    await initialize();
  }

  /// Create the state machine with all possible transitions
  @override
  Future<StateMachine> createStateMachine() async {
    final stateMachine = await StateMachine.create(
      (g) => g
        ..initialState<Solid>()
        ..state<Solid>(
          (b) => b
            ..on<MeltEvent, Liquid>(
              // Guard condition
              condition: (e) => e.nextState.isRightTemperature((e).temperature),
              sideEffect: (H2OEvent e) async {
                _logStateLifecycle(
                    'Temperature above ${e.nextState.minTemperature}°C, melting ice to water');
                _updateState(e.nextState);
              },
            ),
        )
        ..state<Liquid>(
          (b) => b
            ..onEnter(_onEnterState)
            ..onExit(_onExitState)
            ..on<FreezeEvent, Solid>(
              // Guard condition
              condition: (e) => e.nextState.isRightTemperature((e).temperature),
              sideEffect: (H2OEvent e) async {
                _logStateLifecycle(
                    'Temperature at or below ${e.nextState.maxTemperature}°C, freezing water to ice');
                _updateState(e.nextState);
              },
            )
            ..on<VaporizeEvent, Gas>(
              // Guard condition
              condition: (e) => e.nextState.isRightTemperature((e).temperature),
              sideEffect: (H2OEvent e) async {
                _logStateLifecycle(
                    'Temperature above ${e.nextState.minTemperature}°C, vaporizing water to steam');
                _updateState(e.nextState);
              },
            ),
        )
        ..state<Gas>(
          (b) => b
            ..onEnter(_onEnterState)
            ..onExit(_onExitState)
            ..on<CondenseEvent, Liquid>(
              // Guard condition
              condition: (e) => e.nextState.isRightTemperature((e).temperature),
              sideEffect: (H2OEvent e) async {
                _logStateLifecycle(
                    'Temperature at or below ${e.nextState.maxTemperature}°C, condensing steam to water');
                _updateState(e.nextState);
              },
            ),
        )
        ..onTransition(_onTransition),
    );

    return stateMachine;
  }

  /// Update the current state and notify listeners
  void _updateState(H2OState newState) {
    _logStateLifecycle("$newState");
    _currentState = newState;
    notifyStateChanged(newState);
  }

  /// Called when entering a state
  Future<void> _onEnterState(Type state, Event? event) async {
    _logStateLifecycle('Entering $state State');
  }

  /// Called when exiting a state
  Future<void> _onExitState(Type state, Event? event) async {
    _logStateLifecycle('Exiting $state State');
  }

  /// Called during a state transition
  Future<void> _onTransition(
      StateDefinition<State>? previous, Event? event, StateDefinition<State>? current) async {
    _logTransition(previous, event, current);
  }

  /// Log state lifecycle events
  void _logStateLifecycle(String message) {
    if (kDebugMode) {
      print("H2O Lifecycle: $message");
    }
  }

  /// Log state transitions
  void _logTransition(
      StateDefinition<State>? previous, Event? event, StateDefinition<State>? current) {
    if (kDebugMode) {
      print(
          "H2O Transition: ${previous?.stateType} --[${event?.runtimeType}]--> ${current?.stateType}");
    }
  }
}
