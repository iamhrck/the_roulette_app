import 'package:equatable/equatable.dart';
import 'package:the_roulette_app/resource/model/section.dart';
import 'package:the_roulette_app/ui/screen/roulette/roulette_screen.dart';

class RouletteState extends Equatable {
  final Section? winner;
  final List<Section> sections;
  final RouletteAnimation animation;

  const RouletteState(
      {this.winner,
      this.sections = const [],
      this.animation = RouletteAnimation.stop});

  RouletteState copyWith(
      {Section? winner,
      List<Section>? sections,
      RouletteAnimation? animation}) {
    return RouletteState(
        winner: winner ?? this.winner,
        sections: sections ?? this.sections,
        animation: animation ?? this.animation);
  }

  @override
  List<Object?> get props => [winner, sections, animation];
}
