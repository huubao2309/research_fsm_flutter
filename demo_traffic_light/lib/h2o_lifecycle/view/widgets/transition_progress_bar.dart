import 'package:flutter/material.dart';

/// Widget to display a progress bar during state transitions
class TransitionProgressBar extends StatelessWidget {
  /// Current countdown value
  final int countdown;
  
  /// Total duration of the transition
  final int totalDuration;

  /// Creates a new transition progress bar
  const TransitionProgressBar({
    super.key,
    required this.countdown,
    required this.totalDuration,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate progress (inverted because countdown goes down)
    final double progress = 1.0 - (countdown / totalDuration);
    
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Text(
            'Processing: $countdown seconds',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 300,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 20,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
