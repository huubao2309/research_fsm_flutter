import 'package:demo_traffic_light/h2o_lifecycle/controller/h2o_lifecycle_controller.dart';
import 'package:demo_traffic_light/h2o_lifecycle/model/h20_state/h2o_state.dart';
import 'package:demo_traffic_light/h2o_lifecycle/view/widgets/h2o_action_buttons.dart';
import 'package:demo_traffic_light/h2o_lifecycle/view/widgets/h2o_state_display.dart';
import 'package:demo_traffic_light/h2o_lifecycle/view/widgets/transition_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Main screen for the H2O lifecycle demonstration
class H2OLifecycleScreen extends StatelessWidget {
  /// Creates a new H2O lifecycle screen
  const H2OLifecycleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => H2OLifecycleController(),
      child: const _H2OLifecycleView(),
    );
  }
}

class _H2OLifecycleView extends StatelessWidget {
  const _H2OLifecycleView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Life Cycle of H₂O'),
        centerTitle: true,
      ),
      body: Consumer<H2OLifecycleController>(
        builder: (context, controller, _) {
          final H2OState currentState = controller.currentState;
          final int countdown = controller.countdown;
          final bool isTransitioning = controller.isTransitioning;

          return Container(
            color: currentState.color.withOpacity(0.1),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Water state life cycle',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    // Display current state
                    H2OStateDisplay(currentState: currentState),
                    const SizedBox(height: 40),

                    // Show progress bar during transitions
                    if (isTransitioning) ...[
                      TransitionProgressBar(
                        countdown: countdown,
                        totalDuration:
                            currentState is Liquid && controller.currentState.showPositiveButton
                                ? currentState.freezingDurationInSeconds
                                : currentState.transitionDurationInSeconds,
                      ),
                      const SizedBox(height: 30),
                    ],

                    // Action buttons
                    H2OActionButtons(
                      currentState: currentState,
                      isTransitioning: isTransitioning,
                      onNegativePressed: controller.onNegativePressed,
                      onPositivePressed: controller.onPositivePressed,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
