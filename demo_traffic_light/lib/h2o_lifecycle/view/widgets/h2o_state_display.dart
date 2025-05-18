import 'package:demo_traffic_light/h2o_lifecycle/model/h2o_state/h2o_state.dart';
import 'package:flutter/material.dart';

/// Widget to display the current H2O state
class H2OStateDisplay extends StatelessWidget {
  /// The current H2O state
  final H2OState currentState;
  
  /// The current temperature
  final int temperature;

  /// Creates a new H2O state display widget
  const H2OStateDisplay({
    super.key,
    required this.currentState,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: currentState.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: currentState.color, width: 2),
      ),
      child: Column(
        children: [
          // State icon
          Icon(
            currentState.stateIcon,
            size: 80,
            color: currentState.color,
          ),
          const SizedBox(height: 16),
          
          // State name
          Text(
            currentState.name,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: currentState.color,
            ),
          ),
          const SizedBox(height: 8),
          
          // State description
          Text(
            currentState.stateDescription,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          
          // Temperature display
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.thermostat, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  'Temperature: $temperature°C',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          
          // Temperature range
          Text(
            'Range: ${currentState.minTemperature}°C to ${currentState.maxTemperature}°C',
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
