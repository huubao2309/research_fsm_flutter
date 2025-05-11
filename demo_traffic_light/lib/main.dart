import 'package:flutter/material.dart';
import 'traffic_light/traffic_light_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traffic Light Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TrafficLightDemo(),
    );
  }
}

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
