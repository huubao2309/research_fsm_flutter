import 'dart:async';

import 'package:demo_traffic_light/h2o_lifecycle/model/events/h2o_events.dart';
import 'package:demo_traffic_light/h2o_lifecycle/model/h2o_state/h2o_state.dart';
import 'package:demo_traffic_light/h2o_lifecycle/model/h2o_state_machine.dart';
import 'package:flutter/foundation.dart';

/// Controller for the H2O lifecycle advanced demo
class H2OLifecycleController extends ChangeNotifier {
  final int _minTemperature = -200;
  final int _maxTemperature = 300;

  // Increase temperature by 30°C per second
  final int heatingRate = 20;

  // Decrease temperature by 20°C per second
  final int coolingRate = 15;

  /// The state machine
  final H2OStateMachine _stateMachine = H2OStateMachine();

  /// Timer for temperature changes
  Timer? _temperatureTimer;

  /// Subscription to state changes
  late StreamSubscription<H2OState> _stateSubscription;

  /// Current temperature in Celsius
  int _temperature = 0;

  /// Flag to indicate if heating or cooling is in progress
  bool _isChangingTemperature = false;

  /// Flag to indicate if we're heating (true) or cooling (false)
  bool _isHeating = false;

  /// Flag to indicate if we've reached a temperature limit
  bool _hasReachedLimit = false;

  /// Warning message when temperature limit is reached
  String? _warningMessage;

  /// Get the current state
  H2OState get currentState => _stateMachine.currentState;

  /// Get the current temperature
  int get temperature => _temperature;

  /// Check if temperature is changing
  bool get isChangingTemperature => _isChangingTemperature;

  /// Check if we're heating
  bool get isHeating => _isHeating;

  /// Check if we've reached a temperature limit
  bool get hasReachedLimit => _hasReachedLimit;

  /// Get the warning message
  String? get warningMessage => _warningMessage;

  /// Check if heat up button should be enabled
  bool get isHeatUpEnabled {
    // At minimum temperature limit, heat up is always enabled
    if (_temperature <= _minTemperature) return true;

    // At maximum temperature limit, heat up is disabled
    if (_temperature >= _maxTemperature) return false;

    // During normal operation, heat up is enabled when not heating
    return !_isHeating || !_isChangingTemperature;
  }

  /// Check if freeze button should be enabled
  bool get isFreezeEnabled {
    // At maximum temperature limit, freeze is always enabled
    if (_temperature >= _maxTemperature) return true;

    // At minimum temperature limit, freeze is disabled
    if (_temperature <= _minTemperature) return false;

    // During normal operation, freeze is enabled when heating
    return _isHeating || !_isChangingTemperature;
  }

  /// Constructor
  H2OLifecycleController() {
    _init();
  }

  /// Initialize the controller
  Future<void> _init() async {
    await _stateMachine.init();

    // Subscribe to state changes
    _stateSubscription = _stateMachine.stateChanges.listen((newState) {
      _logInfo('State changed to: ${newState.name}');
      notifyListeners();
    });

    _logInfo('H2O lifecycle controller initialized with state: ${currentState.name}');
  }

  /// Handle heat up button press
  void onHeatUpPressed() {
    // Clear any warning message
    _warningMessage = null;
    _hasReachedLimit = false;

    // Special case: If at maximum temperature, start cooling instead
    if (_temperature >= _maxTemperature) {
      _isChangingTemperature = true;
      _isHeating = false;
      _startCoolingProcess();
      notifyListeners();
      return;
    }

    // If we're already heating, do nothing
    if (_isChangingTemperature && _isHeating) return;

    _isChangingTemperature = true;
    _isHeating = true;
    _startHeatingProcess();
    notifyListeners();
  }

  /// Handle freeze button press
  void onFreezePressed() {
    // Clear any warning message
    _warningMessage = null;
    _hasReachedLimit = false;

    // Special case: If at minimum temperature, start heating instead
    if (_temperature <= _minTemperature) {
      _isChangingTemperature = true;
      _isHeating = true;
      _startHeatingProcess();
      notifyListeners();
      return;
    }

    // If we're already cooling, do nothing
    if (_isChangingTemperature && !_isHeating) return;

    _isChangingTemperature = true;
    _isHeating = false;
    _startCoolingProcess();
    notifyListeners();
  }


  /// Start the heating process
  void _startHeatingProcess() {
    _logInfo('Starting heating process from $_temperature°C');
    _temperatureTimer?.cancel();

    _temperatureTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Increase temperature
      _temperature += heatingRate;

      // Check for temperature limits
      if (_temperature >= _maxTemperature) {
        _temperature = _maxTemperature; // Cap at maximum
        _logInfo('Reached maximum temperature limit: $_temperature°C');
        _hasReachedLimit = true;
        _warningMessage = 'Đã đạt nhiệt độ giới hạn';
        _temperatureTimer?.cancel();
      } else {
        _logInfo('Temperature increased to $_temperature°C');
      }

      // Check for state transitions (but don't stop the timer)
      _checkStateTransition(isHeating: true, stopTimer: false);

      notifyListeners();
    });
  }

  /// Start the cooling process
  void _startCoolingProcess() {
    _logInfo('Starting cooling process from $_temperature°C');
    _temperatureTimer?.cancel();

    _temperatureTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Decrease temperature
      _temperature -= coolingRate;

      // Check for temperature limits
      if (_temperature <= _minTemperature) {
        _temperature = _minTemperature; // Cap at minimum
        _logInfo('Reached minimum temperature limit: $_temperature°C');
        _hasReachedLimit = true;
        _warningMessage = 'Đã đạt nhiệt độ giới hạn';
        _temperatureTimer?.cancel();
      } else {
        _logInfo('Temperature decreased to $_temperature°C');
      }

      // Check for state transitions (but don't stop the timer)
      _checkStateTransition(isHeating: false, stopTimer: false);

      notifyListeners();
    });
  }

  /// Check if a state transition should occur based on temperature
  /// [stopTimer] - whether to stop the timer after transition (default: true)
  void _checkStateTransition({required bool isHeating, bool stopTimer = true}) {
    final currentState = _stateMachine.currentState;

    if(isHeating) {
      if(currentState is Solid) {
        // Solid -> Liquid
        _logInfo('Temperature exceeds 0°C, transitioning from Solid to Liquid');
        _stateMachine.applyEvent(MeltEvent(temperature: _temperature));
        if (stopTimer) _stopTemperatureChange();
        return;
      }

      if(currentState is Liquid) {
        // Liquid -> Gas
        _logInfo('Temperature exceeds 100°C, transitioning from Liquid to Gas');
        _stateMachine.applyEvent(VaporizeEvent(temperature: _temperature));
        if (stopTimer) _stopTemperatureChange();
        return;
      }
    }
    // Cooling
    else {
      if(currentState is Liquid) {
        // Liquid -> Solid
        _logInfo('Temperature at or below 0°C, transitioning from Liquid to Solid');
        _stateMachine.applyEvent(FreezeEvent(temperature: _temperature));
        if (stopTimer) _stopTemperatureChange();
        return;
      }

      if(currentState is Gas) {
        // Gas -> Liquid
        _logInfo('Temperature at or below 100°C, transitioning from Gas to Liquid');
        _stateMachine.applyEvent(CondenseEvent(temperature: _temperature));
        if (stopTimer) _stopTemperatureChange();
        return;
      }
    }
  }

  /// Stop the temperature change process
  void _stopTemperatureChange() {
    _temperatureTimer?.cancel();
    _isChangingTemperature = false;
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
    _temperatureTimer?.cancel();
    _stateSubscription.cancel();
    super.dispose();
  }
}
