import 'package:flutter/material.dart';

import 'life_cycle_h20_widget.dart';

class LifeCycleH20Demo extends StatelessWidget {
  const LifeCycleH20Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Life Cycle H20 Demo'),
      ),
      body: const LifeCycleH20Widget(),
    );
  }
}
