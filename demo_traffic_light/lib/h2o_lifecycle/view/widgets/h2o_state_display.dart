import 'package:demo_traffic_light/h2o_lifecycle/model/h20_state/h2o_state.dart';
import 'package:flutter/material.dart';

/// Widget to display the current H2O state
class H2OStateDisplay extends StatelessWidget {
  /// The current H2O state
  final H2OState currentState;

  /// Creates a new H2O state display
  const H2OStateDisplay({
    super.key,
    required this.currentState,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // State name display
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          decoration: BoxDecoration(
            color: currentState.color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: currentState.color, width: 2),
          ),
          child: Text(
            'Current State: ${currentState.name}',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: currentState.color.withOpacity(0.8),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // State description
        Text(
          currentState.stateDescription,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),

        // Visual representation of the state
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: currentState.color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: currentState.color.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
            gradient: RadialGradient(
              colors: [
                currentState.color.withOpacity(0.7),
                currentState.color,
              ],
              stops: const [0.4, 1.0],
            ),
          ),
          child: Icon(
            currentState.stateIcon,
            size: 100,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),

        // Temperature range
        Text(
          currentState.stateTemperature,
          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
