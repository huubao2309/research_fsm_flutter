import 'dart:async';

import 'package:demo_traffic_light/h2o_lifecycle/model/events/h2o_events.dart';
import 'package:demo_traffic_light/h2o_lifecycle/model/h20_state/h2o_state.dart';
import 'package:demo_traffic_light/h2o_lifecycle/model/h2o_state_machine.dart';
import 'package:demo_traffic_light/utils/count_down_timer.dart';
import 'package:flutter/foundation.dart';

/// A class that manages the H2O state machine using fsm2 library
class H2OLifecycleController extends ChangeNotifier {
  /// The state machine
  final H2OStateMachine _stateMachine = H2OStateMachine();

  /// Timer for state transitions
  final CountDownTimer _countDownTimer = CountDownTimer();

  /// Subscription to state changes
  late StreamSubscription<H2OState> _stateSubscription;

  /// Flag to indicate if a transition is in progress
  bool _isTransitioning = false;
  bool get isTransitioning => _isTransitioning;

  /// Get the current state
  H2OState get currentState => _stateMachine.currentState;

  /// Get the current countdown value
  int get countdown => _countDownTimer.countdown;

  /// Creates a new H2O controller
  H2OLifecycleController() {
    _logInfo('Initializing H2O lifecycle controller...');
    _initStateMachine();
  }

  /// Initialize the state machine
  Future<void> _initStateMachine() async {
    // Initialize the state machine
    await _stateMachine.init();

    // Subscribe to state changes
    _stateSubscription = _stateMachine.stateChanges.listen(_onStateChanged);

    _logInfo('H2O state machine initialized with state: ${currentState.name}');
    notifyListeners();
  }

  /// Handle state changes from the state machine
  void _onStateChanged(H2OState newState) {
    _logInfo('State changed to ${newState.name}');
    _isTransitioning = false;
    notifyListeners();
  }

  /// Handle the heat button press based on current state
  void onNegativePressed() {
    if (_isTransitioning) {
      _logInfo('Already transitioning, ignoring heat request');
      return;
    }

    _logInfo('Heat button pressed in ${currentState.name} state');

    if (currentState is Solid) {
      _startMeltingTransition();
    } else if (currentState is Liquid) {
      _startVaporizingTransition();
    }
  }

  /// Handle the freeze button press based on current state
  void onPositivePressed() {
    if (_isTransitioning) {
      _logInfo('Already transitioning, ignoring freeze request');
      return;
    }

    _logInfo('Freeze button pressed in ${currentState.name} state');

    if (currentState is Liquid) {
      _startFreezingTransition();
    } else if (currentState is Gas) {
      _startCondensingTransition();
    }
  }

  /// Start melting transition (Solid -> Liquid)
  void _startMeltingTransition() {
    _isTransitioning = true;
    _startCountdown(
      duration: currentState.transitionDurationInSeconds,
      onComplete: () {
        _stateMachine.applyEvent(MeltEvent());
      },
    );
  }

  /// Start freezing transition (Liquid -> Solid)
  void _startFreezingTransition() {
    _isTransitioning = true;
    final liquid = currentState as Liquid;
    _startCountdown(
      duration: liquid.freezingDurationInSeconds,
      onComplete: () {
        _stateMachine.applyEvent(FreezeEvent());
      },
    );
  }

  /// Start vaporizing transition (Liquid -> Gas)
  void _startVaporizingTransition() {
    _isTransitioning = true;
    _startCountdown(
      duration: currentState.transitionDurationInSeconds,
      onComplete: () {
        _stateMachine.applyEvent(VaporizeEvent());
      },
    );
  }

  /// Start condensing transition (Gas -> Liquid)
  void _startCondensingTransition() {
    _isTransitioning = true;
    _startCountdown(
      duration: currentState.transitionDurationInSeconds,
      onComplete: () {
        _stateMachine.applyEvent(CondenseEvent());
      },
    );
  }

  /// Start a countdown timer for state transitions
  void _startCountdown({required int duration, required VoidCallback onComplete}) {
    _countDownTimer.cancel();
    _countDownTimer.startTimer(
      countdownValue: duration,
      onTick: (int second) {
        _logInfo('Transition tick: $second seconds remaining');
        notifyListeners();
      },
      onDone: () {
        _logInfo('Transition complete');
        onComplete();
      },
    );
    notifyListeners();
  }

  /// Log information messages
  void _logInfo(String message) {
    if (kDebugMode) {
      print('H2OController: $message');
    }
  }

  @override
  void dispose() {
    _logInfo('Disposing H2O lifecycle controller');
    _countDownTimer.cancel();
    _stateSubscription.cancel();
    super.dispose();
  }
}
