import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/traffic_light_controller.dart';
import 'controller/traffic_light_state.dart';

/// A widget that displays a traffic light
class TrafficLightWidget extends StatelessWidget {
  /// Creates a new traffic light widget
  const TrafficLightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        if (kDebugMode) {
          print('Creating TrafficLightFSM instance');
        }
        return TrafficLightFSM();
      },
      child: const _TrafficLightDisplay(),
    );
  }
}

class _TrafficLightDisplay extends StatelessWidget {
  const _TrafficLightDisplay();

  @override
  Widget build(BuildContext context) {
    final fsm = Provider.of<TrafficLightFSM>(context);
    final currentState = fsm.currentState;
    final countdown = fsm.countdown;

    if (kDebugMode) {
      print('Building _TrafficLightDisplay with state: $currentState, countdown: $countdown');
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Traffic Light Demo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text('Current State: ${currentState.toString()}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('Countdown: $countdown seconds', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 30),
          Container(
            width: 120,
            height: 300,
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _LightBulb(color: Colors.red, currentState: currentState, countdownValue: countdown),
                _LightBulb(color: Colors.yellow, currentState: currentState, countdownValue: countdown),
                _LightBulb(color: Colors.green, currentState: currentState, countdownValue: countdown),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LightBulb extends StatelessWidget {
  final Color color;
  final TrafficLightStateBase currentState;
  final int? countdownValue;

  const _LightBulb({required this.color, required this.currentState, this.countdownValue});

  @override
  Widget build(BuildContext context) {
    final Color stateColor = currentState.color;
    final bool isActive = stateColor == color;
    final int? countdown = isActive ? countdownValue : null;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? color : color.withAlpha(76), // 0.3 * 255 = 76
            boxShadow:
                isActive
                    ? [
                      BoxShadow(
                        color: color.withAlpha(178), // 0.7 * 255 = 178
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ]
                    : null,
          ),
        ),
        if (isActive && countdown != null)
          Text('$countdown', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
      ],
    );
  }
}
