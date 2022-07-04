part of 'local_notes_bloc.dart';

abstract class LocalNotesEvent extends Equatable {
  const LocalNotesEvent();

  @override
  List<Object> get props => [];
}

class AddLocalNote extends LocalNotesEvent {
  final LocalNoteEntity localNoteEntity;

  const AddLocalNote({required this.localNoteEntity});

  @override
  List<Object> get props => [localNoteEntity];
}
