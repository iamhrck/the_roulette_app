import 'package:flutter/material.dart';

class RouletteScreen extends StatelessWidget {
  const RouletteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('RouletteScreen'),
        ),
        body: Container(
            alignment: Alignment.center, child: const Text('RouletteScreen')));
  }
}
