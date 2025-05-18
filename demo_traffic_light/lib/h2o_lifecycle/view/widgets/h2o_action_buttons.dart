import 'package:flutter/material.dart';

/// Widget to display action buttons for H2O state transitions
class H2OActionButtons extends StatelessWidget {
  /// Whether the heat up button should be enabled
  final bool isHeatUpEnabled;

  /// Whether the freeze button should be enabled
  final bool isFreezeEnabled;

  /// Callback for heat up button press
  final VoidCallback onHeatUpPressed;

  /// Callback for freeze button press
  final VoidCallback onFreezePressed;

  /// Creates a new H2O action buttons widget
  const H2OActionButtons({
    super.key,
    required this.isHeatUpEnabled,
    required this.isFreezeEnabled,
    required this.onHeatUpPressed,
    required this.onFreezePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Heat up button
        _ActionButton(
          text: 'Heat up',
          icon: Icons.whatshot,
          color: Colors.orange,
          isEnabled: isHeatUpEnabled,
          onPressed: onHeatUpPressed,
        ),
        const SizedBox(width: 20),

        // Freeze button
        _ActionButton(
          text: 'Freeze',
          icon: Icons.ac_unit,
          color: Colors.blue,
          isEnabled: isFreezeEnabled,
          onPressed: onFreezePressed,
        ),
      ],
    );
  }
}

/// A styled action button
class _ActionButton extends StatelessWidget {
  /// Button text
  final String text;

  /// Button icon
  final IconData icon;

  /// Button color
  final Color color;

  /// Whether the button is enabled
  final bool isEnabled;

  /// Callback when button is pressed
  final VoidCallback onPressed;

  /// Creates a new action button
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        disabledBackgroundColor: color.withOpacity(0.3),
        disabledForegroundColor: Colors.white.withOpacity(0.5),
      ),
      icon: Icon(icon, size: 24),
      label: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
