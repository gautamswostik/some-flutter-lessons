import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluuter_boilerplate/application/local_notes/local_notes_bloc.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/local_notes_repo.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/note_adapter/note_entities.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mockito/mockito.dart';

import '../mocks/app_mocks.mocks.dart';

void main() {
  group(
    'Testing Local Notes Bloc',
    () {
      late LocalNotesBloc mockLocalNotesBloc;
      late LocalNotesRepository mockLocalNotesRepository;
      late LocalNoteEntity mockLocalNoteEntity;
      late HiveError mockError;
      setUp(() {
        mockLocalNotesBloc = MockLocalNotesBloc();
        mockLocalNotesRepository = MockLocalNotesRepository();
        mockLocalNoteEntity = MockLocalNoteEntity();
        mockError = MockHiveError();
      });

      test(
        'The LocalNoteBloc should emit LocalNotesInitial as its initial state',
        () {
          when(mockLocalNotesBloc.state).thenReturn(LocalNotesInitial());

          expect(mockLocalNotesBloc.state, isA<LocalNotesInitial>());

          verify(mockLocalNotesBloc.state);
        },
      );

      blocTest<LocalNotesBloc, LocalNotesState>(
        'Should add note and emit [LocalNotesLoading , LocalNewsAdded] when AddLocalNote',
        setUp: () {
          when(mockLocalNotesRepository.addNote(
              localNoteEntity: mockLocalNoteEntity));
        },
        build: () => LocalNotesBloc(
          localNotesRepository: mockLocalNotesRepository,
        ),
        act: (bloc) =>
            bloc.add(AddLocalNote(localNoteEntity: mockLocalNoteEntity)),
        expect: () => [isA<LocalNewsAdded>()],
        verify: (bloc) {
          mockLocalNotesRepository.addNote(
            localNoteEntity: mockLocalNoteEntity,
          );
        },
      );

      blocTest<LocalNotesBloc, LocalNotesState>(
        'Should add note and emit [LocalNotesLoading , LocalNoteAddError] when AddLocalNote',
        setUp: () async {
          when(mockLocalNotesRepository.addNote(
                  localNoteEntity: mockLocalNoteEntity))
              .thenThrow(mockError);
        },
        build: () => LocalNotesBloc(
          localNotesRepository: mockLocalNotesRepository,
        ),
        act: (bloc) =>
            bloc.add(AddLocalNote(localNoteEntity: mockLocalNoteEntity)),
        expect: () => [isA<LocalNoteError>()],
        verify: (bloc) {
          mockLocalNotesRepository.addNote(
            localNoteEntity: mockLocalNoteEntity,
          );
        },
      );
      tearDown(
        () {
          mockLocalNotesBloc.close();
        },
      );
    },
  );
}
