import 'package:flutter/material.dart';
import 'package:the_roulette_app/resource/model/section.dart';
import 'package:the_roulette_app/ui/screen/entry/entry_screen.dart';
import 'package:the_roulette_app/ui/screen/roulette/roulette_screen.dart';

class AppRouter {
  AppRouter._();

  static const String roulette = '/roulette';
  static const String setup = '/setup';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    return PageRouteBuilder(
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final Animatable<Offset> tween = Tween(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      pageBuilder: (_, __, ___) {
        switch (settings.name) {
          case roulette:
            // 引数からデータを取得
            final List<Section> sections = settings.arguments as List<Section>;

            return RouletteScreen(sections: sections);

          case setup:
            return const EntryScreen();

          default:
            return const EntryScreen();
        }
      },
    );
  }
}
