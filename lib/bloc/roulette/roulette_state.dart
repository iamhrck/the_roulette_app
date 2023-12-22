import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RouletteState extends Equatable {
  final String result;
  final List<PieChartSectionData> pieDataList;

  const RouletteState({this.result = '', this.pieDataList = const []});

  Color getWinnerColor() {
    return pieDataList.firstWhere((element) => element.title == result).color;
  }

  RouletteState copyWith(
      {String? result, List<PieChartSectionData>? pieDataList}) {
    return RouletteState(
        result: result ?? this.result,
        pieDataList: pieDataList ?? this.pieDataList);
  }

  @override
  List<Object> get props => [result, pieDataList];
}
