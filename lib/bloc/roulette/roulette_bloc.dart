import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_roulette_app/bloc/roulette/roulette_event.dart';
import 'package:the_roulette_app/bloc/roulette/roulette_state.dart';
import 'package:the_roulette_app/resource/model/section.dart';
import 'package:the_roulette_app/ui/screen/roulette/roulette_screen.dart';

class RouletteBloc extends Bloc<RouletteEvent, RouletteState> {
  RouletteBloc() : super(const RouletteState()) {
    on<ResetRouletteEvent>(_resetRoulette);
    on<JudgeWinnerEvent>(_judgeWinner);
    on<GetPieDataEvent>(_getPieData);
    on<SwitchAnimationEvent>(_switchAnimation);
  }

  void _resetRoulette(ResetRouletteEvent event, Emitter<RouletteState> emit) {
    emit(const RouletteState());
  }

  void _judgeWinner(JudgeWinnerEvent event, Emitter<RouletteState> emit) {
    final sum = state.sections.fold(0, (previous, section) {
      return previous + int.parse(section.ratio);
    });
    double range = 1 / sum;
    Section winner = state.sections.firstWhere((section) {
      return (event.endpoint % 1) <= section.ratioSumFromThis * range;
    });

    emit(state.copyWith(result: winner.sectionName));
  }

  void _getPieData(GetPieDataEvent event, Emitter<RouletteState> emit) {
    final state = this.state;
    emit(state.copyWith(sections: event.sections));
  }

  void _switchAnimation(
      SwitchAnimationEvent event, Emitter<RouletteState> emit) {
    final state = this.state;

    next() {
      switch (state.animation) {
        case RouletteAnimation.stop:
          return RouletteAnimation.inprogress;
        case RouletteAnimation.inprogress:
          return RouletteAnimation.waitting;
        case RouletteAnimation.waitting:
          return RouletteAnimation.stop;
      }
    }

    emit(state.copyWith(animation: next()));
  }
}
