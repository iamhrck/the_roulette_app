import 'package:the_roulette_app/shared/app_event.dart';

abstract class EntryEvent implements AppEvent {
  const EntryEvent();
}

class AddSectionEvent extends EntryEvent {}

class RemoveSectionEvent extends EntryEvent {
  final int index;

  RemoveSectionEvent(this.index);
}
