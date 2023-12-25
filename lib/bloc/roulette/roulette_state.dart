import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:the_roulette_app/ui/screen/roulette/roulette_screen.dart';

class RouletteState extends Equatable {
  final String result;
  final List<PieChartSectionData> pieDataList;
  final RouletteAnimation animation;

  const RouletteState(
      {this.result = '',
      this.pieDataList = const [],
      this.animation = RouletteAnimation.stop});

  Color getWinnerColor() {
    return pieDataList.firstWhere((element) => element.title == result).color;
  }

  RouletteState copyWith(
      {String? result,
      List<PieChartSectionData>? pieDataList,
      RouletteAnimation? animation}) {
    return RouletteState(
        result: result ?? this.result,
        pieDataList: pieDataList ?? this.pieDataList,
        animation: animation ?? this.animation);
  }

  @override
  List<Object> get props => [result, pieDataList, animation];
}
