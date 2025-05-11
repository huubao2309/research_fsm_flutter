import 'dart:async';

import 'package:demo_traffic_light/utils/utils.dart';
import 'package:flutter/material.dart';

class CountDownTimer {
  /// Timer for state transitions
  Timer? _timer;

  /// Current countdown value
  int _countdown = 0;

  /// Get the current countdown value
  int get countdown => _countdown;

  set setCountdown(int countdown) {
    _countdown = countdown;
  }

  void startTimer({required Function(int) onTick, required VoidCallback onDone, required int countdownValue}) {
    _timer?.cancel();

    _countdown = countdownValue;

    Utils.log('Starting timer with countdown: $_countdown');

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _countdown--;
      onTick.call(_countdown);

      if (_countdown <= 0) {
        Utils.log('Countdown reached zero, transitioning to next state');
        _timer?.cancel();
        onDone.call();
      }
    });
  }

  void cancel() {
    _timer?.cancel();
  }
}
