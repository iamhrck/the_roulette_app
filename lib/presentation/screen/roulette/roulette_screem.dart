import 'package:flutter/material.dart';
import 'package:the_roulette_app/presentation/components/app_bar.dart';
import 'package:the_roulette_app/shared/constants/strings.dart';

class RouletteScreen extends StatelessWidget {
  const RouletteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: Strings.appTitle),
        body: Container(
            alignment: Alignment.center, child: const Text('RouletteScreen')));
  }
}
