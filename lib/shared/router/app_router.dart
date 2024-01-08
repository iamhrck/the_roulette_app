import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:the_roulette_app/resource/model/section.dart';
import 'package:the_roulette_app/ui/screen/entry/entry_screen.dart';
import 'package:the_roulette_app/ui/screen/roulette/roulette_screen.dart';

class AppRouter {
  AppRouter._();

  static const String roulette = '/roulette';
  static const String setup = '/setup';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case roulette:
        // 引数からデータを取得
        final List<Section> sections = settings.arguments as List<Section>;

        return MaterialPageRoute(
          builder: (BuildContext context) => RouletteScreen(sections: sections),
        );

      case setup:
        return MaterialPageRoute(
          builder: (BuildContext context) => const EntryScreen(),
        );

      default:
        return null;
    }
  }
}
