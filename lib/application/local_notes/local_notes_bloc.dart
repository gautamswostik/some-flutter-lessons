import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/local_notes_repo.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/note_adapter/note_entities.dart';

part 'local_notes_event.dart';
part 'local_notes_state.dart';

class LocalNotesBloc extends Bloc<LocalNotesEvent, LocalNotesState> {
  final LocalNotesRepository localNotesRepository;
  LocalNotesBloc({required this.localNotesRepository})
      : super(LocalNotesInitial()) {
    on<LocalNotesEvent>((event, emit) {});

    on<AddLocalNote>((event, emit) async {
      emit(LocalNotesLoading());
      try {
        await localNotesRepository.addNote(
          localNoteEntity: event.localNoteEntity,
        );
        emit(const LocalNewsAdded(message: 'Added Sucessfully'));
      } catch (e) {
        emit(LocalNewsAddError(errorMessage: e.toString()));
      }
    });
  }
}
