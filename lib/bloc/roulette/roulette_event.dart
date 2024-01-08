import 'package:fl_chart/fl_chart.dart';
import 'package:the_roulette_app/resource/model/section.dart';
import 'package:the_roulette_app/shared/app_event.dart';

abstract class RouletteEvent implements AppEvent {
  const RouletteEvent();
}

class JudgeWinnerEvent extends RouletteEvent {
  final double endpoint;
  JudgeWinnerEvent({required this.endpoint});
}

class ResetRouletteEvent extends RouletteEvent {}

class GetPieDataEvent extends RouletteEvent {
  // final List<PieChartSectionData> sections;
  final List<Section> sections;
  GetPieDataEvent({required this.sections});
}

class SwitchAnimationEvent extends RouletteEvent {}
