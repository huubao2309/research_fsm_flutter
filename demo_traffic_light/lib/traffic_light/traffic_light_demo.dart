import 'package:demo_traffic_light/traffic_light/traffic_light_widget.dart';
import 'package:flutter/material.dart';

class TrafficLightDemo extends StatelessWidget {
  const TrafficLightDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Traffic Light FSM Demo'),
      ),
      body: const TrafficLightWidget(),
    );
  }
}
