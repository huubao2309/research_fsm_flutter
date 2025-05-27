import 'package:export_fsm_images/student_infos/student_events.dart';
import 'package:export_fsm_images/student_infos/student_states.dart';
import 'package:fsm2/fsm2.dart';

/// Initialize the state machine
Future<void> exportStudentInfos() async {
  await StateMachine.create(
    (g) => g
      ..initialState<InitialState>()
      ..state<InitialState>(
        (b) => b
          ..on<FetchStudentsEvent, LoadingState>(
            sideEffect: (event) async {},
          ),
      )
      ..state<LoadingState>(
        (b) => b
          ..on<StudentsLoadedEvent, LoadedState>(
            sideEffect: (event) async {},
          )
          ..on<ErrorEvent, ErrorState>(
            sideEffect: (event) async {},
          ),
      )
      ..state<LoadedState>(
        (b) => b
          ..on<FetchStudentsEvent, LoadingState>(
            sideEffect: (event) async {},
          ),
      )
      ..state<ErrorState>(
        (b) => b
          ..on<FetchStudentsEvent, LoadingState>(
            sideEffect: (event) async {},
          ),
      ),
  );
}
