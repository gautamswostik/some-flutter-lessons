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
        emit(LocalNotesLoading());

        final note = await localNotesRepository.addNote(
          localNoteEntity: event.localNoteEntity,
        );

        emit(
          note.fold(
            (failure) => LocalNoteError(errorMessage: failure),
            (success) => const LocalNoteAdded(message: 'Added Sucessfully'),
          ),
        );
      },
    );

    on<GetLocalNotes>(
      (event, emit) async {
        emit(LocalNotesLoading());

        final note = await localNotesRepository.getLocalNotes();

        emit(
          note.fold(
            (failure) => LocalNoteError(errorMessage: failure),
            (notes) => GetSavedLocalNotes(localNoteEntities: notes),
          ),
        );
      },
    );

    on<EditLocalNote>(
      (event, emit) async {
        emit(LocalNotesLoading());

        final note = await localNotesRepository.editData(
          localNoteEntity: event.localNoteEntity,
          key: event.key,
        );

        emit(
          note.fold(
            (failure) => LocalNoteError(errorMessage: failure),
            (notes) => LocalNoteEdited(),
          ),
        );
      },
    );

    on<DeleteLocalNote>(
      (event, emit) async {
        emit(LocalNotesLoading());
        final note = await localNotesRepository.deleteData(key: event.key);

        emit(
          note.fold(
            (failure) => LocalNoteError(errorMessage: failure),
            (notes) => LocalNoteDelted(),
          ),
        );
      },
    );
  }
}
