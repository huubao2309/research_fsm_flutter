import 'package:flutter/material.dart';

/// Widget to display a temperature indicator with animation
class TemperatureIndicator extends StatelessWidget {
  /// Current temperature
  final int temperature;

  /// Whether temperature is changing
  final bool isChangingTemperature;

  /// Whether temperature is increasing
  final bool isIncreasing;

  // Increase temperature rate
  final int heatingRate;

  // Decrease temperature rate
  final int coolingRate;

  /// Creates a new temperature indicator
  const TemperatureIndicator({
    super.key,
    required this.temperature,
    required this.isChangingTemperature,
    required this.isIncreasing,
    required this.heatingRate,
    required this.coolingRate,
  });

  @override
  Widget build(BuildContext context) {
    // Determine color and icon based on temperature
    Color temperatureColor;
    IconData temperatureIcon;

    if (temperature <= 0) {
      temperatureColor = Colors.blue;
      temperatureIcon = Icons.ac_unit;
    } else if (temperature <= 100) {
      temperatureColor = Colors.green;
      temperatureIcon = Icons.water_drop;
    } else {
      temperatureColor = Colors.red;
      temperatureIcon = Icons.local_fire_department;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Temperature value
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                temperatureIcon,
                color: temperatureColor,
                size: 32,
              ),
              const SizedBox(width: 8),
              Text(
                '$temperature°C',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: temperatureColor,
                ),
              ),
              if (isChangingTemperature) ...[
                const SizedBox(width: 8),
                Icon(
                  isIncreasing ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isIncreasing ? Colors.red : Colors.blue,
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),

          // Temperature change indicator
          if (isChangingTemperature) ...[
            Text(
              isIncreasing ? '+$heatingRate°C per second' : '-$coolingRate°C per second',
              style: TextStyle(
                fontSize: 14,
                color: isIncreasing ? Colors.red : Colors.blue,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isIncreasing ? 'Heating...' : 'Cooling...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isIncreasing ? Colors.orange : Colors.blue,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
