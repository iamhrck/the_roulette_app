import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
        final List<PieChartSectionData> sections =
            settings.arguments as List<PieChartSectionData>;

        return MaterialPageRoute(
          builder: (BuildContext context) => RouletteScreen(sections: sections),
        );

      default:
        return null;
    }
  }
}
