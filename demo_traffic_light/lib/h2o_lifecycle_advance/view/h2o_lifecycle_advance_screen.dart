import 'package:demo_traffic_light/h2o_lifecycle_advance/controller/h2o_lifecycle_controller.dart';
import 'package:demo_traffic_light/h2o_lifecycle_advance/model/h2o_state/h2o_state.dart';
import 'package:demo_traffic_light/h2o_lifecycle_advance/view/widgets/h2o_action_buttons.dart';
import 'package:demo_traffic_light/h2o_lifecycle_advance/view/widgets/h2o_state_display.dart';
import 'package:demo_traffic_light/h2o_lifecycle_advance/view/widgets/temperature_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Main screen for the H2O lifecycle advanced demonstration
class H2OLifecycleAdvanceScreen extends StatelessWidget {
  /// Creates a new H2O lifecycle advanced screen
  const H2OLifecycleAdvanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => H2OLifecycleController(),
      child: const _H2OLifecycleAdvanceView(),
    );
  }
}

class _H2OLifecycleAdvanceView extends StatelessWidget {
  const _H2OLifecycleAdvanceView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('H₂O Lifecycle Advanced'),
        centerTitle: true,
      ),
      body: Consumer<H2OLifecycleController>(
        builder: (context, controller, _) {
          final H2OState currentState = controller.currentState;
          final int temperature = controller.temperature;
          final bool isChangingTemperature = controller.isChangingTemperature;
          final bool isHeating = controller.isHeating;
          final bool hasReachedLimit = controller.hasReachedLimit;
          final String? warningMessage = controller.warningMessage;

          return Container(
            color: currentState.color.withOpacity(0.05),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'H₂O State Transitions',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    // Temperature indicator
                    TemperatureIndicator(
                      temperature: temperature,
                      isChangingTemperature: isChangingTemperature,
                      isIncreasing: isHeating,
                      heatingRate: controller.heatingRate,
                      coolingRate: controller.coolingRate,
                    ),
                    const SizedBox(height: 20),

                    // Warning message
                    if (hasReachedLimit && warningMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.warning_amber_rounded, color: Colors.red),
                            const SizedBox(width: 8),
                            Text(
                              warningMessage,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Display current state
                    H2OStateDisplay(
                      currentState: currentState,
                      temperature: temperature,
                    ),
                    const SizedBox(height: 40),

                    // Action buttons
                    H2OActionButtons(
                      isHeatUpEnabled: controller.isHeatUpEnabled,
                      isFreezeEnabled: controller.isFreezeEnabled,
                      onHeatUpPressed: controller.onHeatUpPressed,
                      onFreezePressed: controller.onFreezePressed,
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
