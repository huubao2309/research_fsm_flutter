import 'package:fsm2/fsm2.dart';

import 'model/events/h2o_events.dart';
import 'model/h20_state/h2o_state.dart';

Future<void> exportH20LifeCycle() async {
  final machine = await StateMachine.create(
    (g) =>
        g
          ..initialState<Solid>()
          ..state<Solid>(
            (b) =>
                b..on<MeltEvent, Liquid>(
                  sideEffect: (H2OEvent e) async {
                    // _updateState(e.nextState);
                  },
                ),
          )
          ..state<Liquid>(
            (b) =>
                b
                  ..onEnter((from, to) {})
                  ..onExit((from, to) {})
                  ..on<FreezeEvent, Solid>(
                    sideEffect: (H2OEvent e) async {
                      // _updateState(e.nextState);
                    },
                  )
                  ..on<VaporizeEvent, Gas>(
                    sideEffect: (H2OEvent e) async {
                      // _updateState(e.nextState);
                    },
                  ),
          )
          ..state<Gas>(
            (b) =>
                b
                  ..onEnter((from, to) {})
                  ..onExit((from, to) {})
                  ..on<CondenseEvent, Liquid>(
                    sideEffect: (H2OEvent e) async {
                      // _updateState(e.nextState);
                    },
                  ),
          )
          ..onTransition((from, to, event) {}),
  );

  machine
    ..analyse()
    ..export('images/water.smcat');
}
