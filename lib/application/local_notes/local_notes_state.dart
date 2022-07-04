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

class LocalNewsAddError extends LocalNotesState {
  final String errorMessage;

  const LocalNewsAddError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
