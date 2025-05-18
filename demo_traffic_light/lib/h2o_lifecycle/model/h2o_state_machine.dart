import 'package:demo_traffic_light/core/fsm/base_state_machine.dart';
import 'package:demo_traffic_light/h2o_lifecycle/model/events/h2o_events.dart';
import 'package:demo_traffic_light/h2o_lifecycle/model/h20_state/h2o_state.dart';
import 'package:fsm2/fsm2.dart';

import '../utils/log_utils.dart';
import '../utils/log_utils_impl.dart';

/// State machine for H2O lifecycle
class H2OStateMachine extends BaseStateMachine<H2OState> {
  /// The current state of the state machine
  H2OState _currentState;

  /// Get the current state
  @override
  H2OState get currentState => _currentState;

  final LogUtils _logUtils = LogUtilsImpl();

  late StateMachine _stateMachine;

  /// Initialize the state machine
  Future<void> init() async {
    await initialize();
  }

  /// Creates a new H2O state machine
  H2OStateMachine() : _currentState = Solid();

  /// Create the state machine with all possible transitions
  @override
  Future<StateMachine> createStateMachine() async {
    _stateMachine = await StateMachine.create(
      (g) => g
        ..initialState<Solid>()
        ..state<Solid>(
          (b) => b
            ..on<MeltEvent, Liquid>(
              sideEffect: (H2OEvent e) async {
                _updateState(e.nextState);
              },
            ),
        )
        ..state<Liquid>(
          (b) => b
            ..onEnter(_onEnterState)
            ..onExit(_onExitState)
            ..on<FreezeEvent, Solid>(
              sideEffect: (H2OEvent e) async {
                _updateState(e.nextState);
              },
            )
            ..on<VaporizeEvent, Gas>(
              sideEffect: (H2OEvent e) async {
                _updateState(e.nextState);
              },
            ),
        )
        ..state<Gas>(
          (b) => b
            ..onEnter(_onEnterState)
            ..onExit(_onExitState)
            ..on<CondenseEvent, Liquid>(
              sideEffect: (H2OEvent e) async {
                _updateState(e.nextState);
              },
            ),
        )
        ..onTransition(_onTransition),
    );

    return _stateMachine;
  }

  /// Update the current state and notify listeners
  void _updateState(H2OState newState) {
    _logUtils.logStateLifecycle("$newState");
    _currentState = newState;
    notifyStateChanged(newState);
  }

  /// Called when entering a state
  Future<void> _onEnterState(Type state, Event? event) async {
    _logUtils.logStateLifecycle('Entering $state State');
  }

  /// Called when exiting a state
  Future<void> _onExitState(Type state, Event? event) async {
    _logUtils.logStateLifecycle('Exiting $state State');
  }

  Future<void> _onTransition(
      StateDefinition<State>? previous, Event? event, StateDefinition<State>? current) async {
    _logUtils.logTransition(previous, event, current);
  }
}
