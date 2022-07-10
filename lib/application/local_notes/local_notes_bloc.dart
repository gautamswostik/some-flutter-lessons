import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/local_notes_repo.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/note_adapter/note_entities.dart';
import 'package:hive_flutter/adapters.dart';

part 'local_notes_event.dart';
part 'local_notes_state.dart';

class LocalNotesBloc extends Bloc<LocalNotesEvent, LocalNotesState> {
  final LocalNotesRepository localNotesRepository;
  LocalNotesBloc({required this.localNotesRepository})
      : super(LocalNotesInitial()) {
    on<LocalNotesEvent>((event, emit) {});

    on<AddLocalNote>(
      (event, emit) async {
        // emit(LocalNotesLoading());
        try {
          await localNotesRepository.addNote(
            localNoteEntity: event.localNoteEntity,
          );
          emit(const LocalNewsAdded(message: 'Added Sucessfully'));
        } on HiveError catch (e) {
          emit(LocalNoteError(errorMessage: e.toString()));
        }
      },
    );

    on<GetLocalNotes>(
      (event, emit) async {
        emit(LocalNotesLoading());
        try {
          List<LocalNoteEntity> notes =
              await localNotesRepository.getLocalNotes();
          emit(
            GetSavedLocalNotes(localNoteEntities: notes),
          );
        } on HiveError catch (e) {
          emit(LocalNoteError(errorMessage: e.toString()));
        }
      },
    );

    on<EditLocalNote>(
      (event, emit) async {
        emit(LocalNotesLoading());
        try {
          await localNotesRepository.editData(
            localNoteEntity: event.localNoteEntity,
            key: event.key,
          );
          emit(LocalNoteEdited());
        } catch (e) {
          emit(LocalNoteError(errorMessage: e.toString()));
        }
      },
    );

    on<DeleteLocalNote>(
      (event, emit) async {
        emit(LocalNotesLoading());
        try {
          await localNotesRepository.deleteData(key: event.key);
          emit(
            LocalNoteDelted(),
          );
        } catch (e) {
          emit(LocalNoteError(errorMessage: e.toString()));
        }
      },
    );
  }
}
