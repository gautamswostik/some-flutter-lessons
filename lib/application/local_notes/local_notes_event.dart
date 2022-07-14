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

class EditLocalNote extends LocalNotesEvent {
  final LocalNoteEntity localNoteEntity;
  final dynamic key;

  const EditLocalNote({required this.localNoteEntity, required this.key});

  @override
  List<Object> get props => [localNoteEntity, key];
}

class GetLocalNotes extends LocalNotesEvent {}

class DeleteLocalNote extends LocalNotesEvent {
  final dynamic key;

  const DeleteLocalNote({required this.key});

  @override
  List<Object> get props => [key];
}
