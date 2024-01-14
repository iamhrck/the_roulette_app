import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_roulette_app/bloc/entry/entry_event.dart';
import 'package:the_roulette_app/bloc/entry/entry_state.dart';
import 'package:the_roulette_app/resource/model/section.dart';

final List<Color> colors = [
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.orange,
  Colors.purple,
  Colors.pink,
  Colors.brown,
  Colors.grey,
  Colors.lime,
  Colors.black,
];

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  EntryBloc() : super(EntryState(sections: [Section(id: 0)])) {
    on<AddSectionEvent>(_addSection);
    on<RemoveSectionEvent>(_removeSection);
  }

  void _addSection(AddSectionEvent event, Emitter<EntryState> emit) {
    final state = this.state;

    final int id = state.sections[state.sections.length - 1].id + 1;

    final Color color = colors.where((element) {
          return !state.sections.map((e) => e.color).contains(element);
        }).firstOrNull ??
        Colors.white;

    final sections = [...state.sections, Section(id: id, color: color)];
    emit(state.copyWith(sections: sections));
  }

  void _removeSection(RemoveSectionEvent event, Emitter<EntryState> emit) {
    final state = this.state;

    final sections = state.sections.where((s) => s.id != event.index).toList();
    emit(state.copyWith(sections: sections));
  }
}
