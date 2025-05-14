import 'package:demo_traffic_light/traffic_light/controller/traffic_light_state.dart';
import 'package:fsm2/fsm2.dart';

import '../../utils/utils.dart';

/// Event to transition to the next state
class NextStateEvent extends Event {}

typedef OnStateChanged = Function(TrafficLightStateBase);

class TrafficLightStateMachine {
  /// Must call createStateMachine() to initial
  late StateMachine _stateMachine;

  /// Note: Change [initialState] in graph of [StateMachine.create]
  final TrafficLightStateBase initState = GreenState();

  Future<void> createStateMachine(OnStateChanged onStateChanged) async {
    _stateMachine = await StateMachine.create(
      (g) =>
          g
            ..initialState<GreenState>()
            ..state<GreenState>(
              (b) =>
                  b..on<NextStateEvent, YellowState>(
                    sideEffect: (e) async {
                      Utils.log('Transitioning from Green to Yellow');
                      onStateChanged.call(YellowState());
                      return;
                    },
                  ),
            )
            ..state<YellowState>(
              (b) =>
                  b..on<NextStateEvent, RedState>(
                    sideEffect: (e) async {
                      Utils.log('Transitioning from Yellow to Red');
                      onStateChanged.call(RedState());
                      return;
                    },
                  ),
            )
            ..state<RedState>(
              (b) =>
                  b..on<NextStateEvent, GreenState>(
                    sideEffect: (e) async {
                      Utils.log('Transitioning from Red to Green');
                      onStateChanged.call(GreenState());
                      return;
                    },
                  ),
            ),
    );
  }

  void applyEvent<E extends Event>(E event) {
    _stateMachine.applyEvent(event);
  }
}
