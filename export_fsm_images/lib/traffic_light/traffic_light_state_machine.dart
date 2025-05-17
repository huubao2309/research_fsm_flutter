import 'package:export_fsm_images/traffic_light/traffic_light_state.dart';
import 'package:fsm2/fsm2.dart';

/// Event to transition to the next state
class NextStateEvent extends Event {}

Future<void> exportTrafficLight() async {
  final StateMachine stateMachine = await StateMachine.create(
    (g) =>
        g
          ..initialState<GreenState>()
          ..state<GreenState>((b) => b..on<NextStateEvent, YellowState>(sideEffect: (e) async {}))
          ..state<YellowState>((b) => b..on<NextStateEvent, RedState>(sideEffect: (e) async {}))
          ..state<RedState>((b) => b..on<NextStateEvent, GreenState>(sideEffect: (e) async {})),
  );

  stateMachine
    ..analyse()
    ..export('images/traffic_light.smcat');
}
