import 'dart:async';

import 'package:demo_traffic_light/traffic_light/controller/traffic_light_state.dart';
import 'package:flutter/foundation.dart';

import '../../utils/count_down_timer.dart';
import '../../utils/utils.dart';
import 'traffic_light_state_machine.dart';

/// A class that manages the traffic light state machine using fsm2 library
class TrafficLightFSM extends ChangeNotifier {
  /// Init variables
  final TrafficLightStateMachine _fsmHandler = TrafficLightStateMachine();
  final CountDownTimer _countDownTimer = CountDownTimer();

  /// Get the current state
  TrafficLightStateBase get currentState {
    // Since we can't use async in a getter, we'll use a simpler approach
    // based on the state we're tracking internally
    return _currentTrafficLightState;
  }

  /// Get the current countdown value
  int get countdown => _countDownTimer.countdown;

  // Internal state tracking
  late TrafficLightStateBase _currentTrafficLightState;

  /// Creates a new traffic light FSM
  TrafficLightFSM() {
    Utils.log('Initializing traffic light FSM...');

    // Define the FSM
    _initFSM();
  }

  /// Initialize the FSM
  Future<void> _initFSM() async {
    _currentTrafficLightState = _fsmHandler.initState;
    _countDownTimer.setCountdown = _currentTrafficLightState.durationInSeconds;
    await _fsmHandler.createStateMachine(_onStateChanged);

    // Initialize with countdown & Start the timer
    _startTimer(countdown: _currentTrafficLightState.durationInSeconds);

    Utils.log('Traffic light FSM initialized with state: ${currentState.name}');
  }

  /// Handle state changes
  void _onStateChanged(TrafficLightStateBase newState) {
    // Update the current state
    _currentTrafficLightState = newState;

    // Update the countdown & Start the timer for the new state
    _startTimer(countdown: newState.durationInSeconds);

    // Notify listeners of the state change
    notifyListeners();

    Utils.log('Transitioned to ${newState.name} state with countdown: ${_countDownTimer.countdown}');
  }

  /// Transition to the next state
  void _transitionToNextState() {
    Utils.log('Triggering next state transition');

    _countDownTimer.cancel();

    // Trigger the transition
    _fsmHandler.applyEvent(NextStateEvent());
  }

  /// Start the timer for the current state
  void _startTimer({required int countdown}) {
    _countDownTimer.startTimer(
      countdownValue: countdown,
      onTick: (int second) {
        notifyListeners();
      },
      onDone: () {
        _transitionToNextState();
      },
    );
  }

  @override
  void dispose() {
    Utils.log('Disposing traffic light FSM');
    _countDownTimer.cancel();
    super.dispose();
  }
}
