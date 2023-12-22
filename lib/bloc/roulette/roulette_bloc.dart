import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_roulette_app/bloc/roulette/roulette_event.dart';
import 'package:the_roulette_app/bloc/roulette/roulette_state.dart';
import 'package:the_roulette_app/shared/constants/app_colors.dart';
import 'package:the_roulette_app/shared/constants/app_text_style.dart';

class RouletteBloc extends Bloc<RouletteEvent, RouletteState> {
  RouletteBloc() : super(const RouletteState()) {
    on<ResetRouletteEvent>(_resetRoulette);
    on<JudgeWinnerEvent>(_judgeWinner);
    on<GetPieDataEvent>(_getPieData);
  }

  void _resetRoulette(ResetRouletteEvent event, Emitter<RouletteState> emit) {
    emit(const RouletteState());
  }

  void _judgeWinner(JudgeWinnerEvent event, Emitter<RouletteState> emit) {
    double range = 1 / state.pieDataList.length;
    int index = (event.endpoint % 1 / range).ceil() - 1;
    emit(state.copyWith(result: state.pieDataList[index].title));
  }

  void _getPieData(GetPieDataEvent event, Emitter<RouletteState> emit) {
    final state = this.state;
    emit(state.copyWith(pieDataList: [
      PieChartSectionData(
          value: 1,
          radius: 100,
          color: Colors.blue.withOpacity(0.85),
          title: "Blue",
          titleStyle: AppTextStyle.headline4.copyWith(color: AppColors.white)),
      PieChartSectionData(
          value: 1,
          radius: 100,
          color: Colors.red.withOpacity(0.85),
          title: "Red",
          titleStyle: AppTextStyle.headline4.copyWith(color: AppColors.white)),
      PieChartSectionData(
          value: 1,
          radius: 100,
          color: Colors.green.withOpacity(0.85),
          title: "Green",
          titleStyle: AppTextStyle.headline4.copyWith(color: AppColors.white)),
      PieChartSectionData(
          value: 1,
          radius: 100,
          color: Colors.orange.withOpacity(0.85),
          title: "Orange",
          titleStyle: AppTextStyle.headline4.copyWith(color: AppColors.white)),
      PieChartSectionData(
          value: 1,
          radius: 100,
          color: Colors.purple.withOpacity(0.85),
          title: "Purple",
          titleStyle: AppTextStyle.headline4.copyWith(color: AppColors.white)),
      PieChartSectionData(
          value: 1,
          radius: 100,
          color: Colors.pink.withOpacity(0.85),
          title: "Pink",
          titleStyle: AppTextStyle.headline4.copyWith(color: AppColors.white))
    ]));
  }
}
