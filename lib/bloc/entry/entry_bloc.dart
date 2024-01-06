import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_roulette_app/bloc/entry/entry_event.dart';
import 'package:the_roulette_app/bloc/entry/entry_state.dart';
import 'package:the_roulette_app/resource/model/section.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  EntryBloc() : super(EntryState(sections: [Section(id: 0)])) {
    on<AddSectionEvent>(_addSection);
    on<RemoveSectionEvent>(_removeSection);
  }

  void _addSection(AddSectionEvent event, Emitter<EntryState> emit) {
    final state = this.state;

    final sections = [...state.sections, Section(id: state.sections.length)];
    emit(state.copyWith(sections: sections));
  }

  void _removeSection(RemoveSectionEvent event, Emitter<EntryState> emit) {
    final state = this.state;

    final sections = state.sections.where((s) => s.id != event.index).toList();
    emit(state.copyWith(sections: sections));
  }
}
