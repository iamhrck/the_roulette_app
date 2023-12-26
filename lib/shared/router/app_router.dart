import 'package:flutter/widgets.dart';
import 'package:the_roulette_app/ui/screen/roulette/roulette_screen.dart';

class AppRouter {
  AppRouter._();

  static const String roulette = '/roulette';

  static final routes = <String, WidgetBuilder>{
    roulette: (BuildContext context) => const RouletteScreen(),
  };
}
