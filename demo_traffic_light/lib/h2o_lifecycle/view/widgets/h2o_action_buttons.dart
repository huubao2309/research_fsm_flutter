import 'package:demo_traffic_light/h2o_lifecycle/model/h20_state/h2o_state.dart';
import 'package:flutter/material.dart';

/// Widget to display action buttons for H2O state transitions
class H2OActionButtons extends StatelessWidget {
  /// The current H2O state
  final H2OState currentState;

  /// Whether a transition is in progress
  final bool isTransitioning;

  /// Callback for heat button press
  final VoidCallback onNegativePressed;

  /// Callback for freeze button press
  final VoidCallback onPositivePressed;

  /// Creates a new H2O action buttons widget
  const H2OActionButtons({
    super.key,
    required this.currentState,
    required this.isTransitioning,
    required this.onNegativePressed,
    required this.onPositivePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Negative button (Solid -> Liquid or Liquid -> Gas)
        if (currentState.showNegativeButton) ...[
          _ActionButton(
            text: currentState.negativeButtonText,
            icon: Icons.whatshot,
            color: Colors.orange,
            isEnabled: !isTransitioning,
            onPressed: onNegativePressed,
          ),
          const SizedBox(height: 16),
        ],

        // Positive button (Liquid -> Solid or Gas -> Liquid)
        if (currentState.showPositiveButton) ...[
          _ActionButton(
            text: currentState.positiveButtonText,
            icon: Icons.ac_unit,
            color: Colors.blue,
            isEnabled: !isTransitioning,
            onPressed: onPositivePressed,
          ),
        ],
      ],
    );
  }
}

/// A styled action button
class _ActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final bool isEnabled;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.text,
    required this.icon,
    required this.color,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        disabledBackgroundColor: color.withOpacity(0.3),
        disabledForegroundColor: Colors.white.withOpacity(0.5),
      ),
      icon: Icon(icon, size: 24),
      label: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
