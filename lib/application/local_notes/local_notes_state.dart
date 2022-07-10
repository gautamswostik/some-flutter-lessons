part of 'local_notes_bloc.dart';

abstract class LocalNotesState extends Equatable {
  const LocalNotesState();

  @override
  List<Object> get props => [];
}

class LocalNotesInitial extends LocalNotesState {}

class LocalNotesLoading extends LocalNotesState {}

class LocalNewsAdded extends LocalNotesState {
  final String message;

  const LocalNewsAdded({required this.message});

  @override
  List<Object> get props => [message];
}

class GetSavedLocalNotes extends LocalNotesState {
  final List<LocalNoteEntity> localNoteEntities;

  const GetSavedLocalNotes({required this.localNoteEntities});

  @override
  List<Object> get props => [localNoteEntities];
}

class LocalNoteError extends LocalNotesState {
  final String errorMessage;

  const LocalNoteError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class LocalNoteDelted extends LocalNotesState {}

class LocalNoteEdited extends LocalNotesState {}
