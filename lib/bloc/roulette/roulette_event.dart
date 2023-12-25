import 'package:the_roulette_app/shared/app_event.dart';

abstract class RouletteEvent implements AppEvent {
  const RouletteEvent();
}

class JudgeWinnerEvent extends RouletteEvent {
  final double endpoint;
  JudgeWinnerEvent({required this.endpoint});
}

class ResetRouletteEvent extends RouletteEvent {}

class GetPieDataEvent extends RouletteEvent {}

class SwitchAnimationEvent extends RouletteEvent {}
