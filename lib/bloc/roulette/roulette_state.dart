import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:the_roulette_app/bloc/entry/entry_state.dart';
import 'package:the_roulette_app/resource/model/section.dart';
import 'package:the_roulette_app/ui/screen/roulette/roulette_screen.dart';

class RouletteState extends Equatable {
  final String result;
  final List<Section> sections;
  final RouletteAnimation animation;

  const RouletteState(
      {this.result = '',
      this.sections = const [],
      this.animation = RouletteAnimation.stop});

  Color getWinnerColor() {
    return sections
        .toPieChartSection()
        .firstWhere((element) => element.title == result,
            orElse: () => PieChartSectionData())
        .color;
  }

  RouletteState copyWith(
      {String? result, List<Section>? sections, RouletteAnimation? animation}) {
    return RouletteState(
        result: result ?? this.result,
        sections: sections ?? this.sections,
        animation: animation ?? this.animation);
  }

  @override
  List<Object> get props => [result, sections, animation];
}
