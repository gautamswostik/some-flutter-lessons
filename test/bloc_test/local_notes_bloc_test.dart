import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluuter_boilerplate/application/local_notes/local_notes_bloc.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/local_notes_repo.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/note_adapter/note_entities.dart';
import 'package:mockito/mockito.dart';

import '../mocks/app_mocks.mocks.dart';

void main() {
  group(
    'Testing Local Notes Bloc',
    () {
      late LocalNotesBloc mockLocalNotesBloc;
      late LocalNotesRepository mockLocalNotesRepository;
      late LocalNoteEntity mockLocalNoteEntity;

      setUp(() {
        mockLocalNotesBloc = MockLocalNotesBloc();
        mockLocalNotesRepository = MockLocalNotesRepository();
        mockLocalNoteEntity = MockLocalNoteEntity();
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
                  localNoteEntity: mockLocalNoteEntity))
              .thenAnswer((_) async => const Right(unit));
        },
        build: () => LocalNotesBloc(
          localNotesRepository: mockLocalNotesRepository,
        ),
        act: (bloc) =>
            bloc.add(AddLocalNote(localNoteEntity: mockLocalNoteEntity)),
        expect: () => [isA<LocalNotesLoading>(), isA<LocalNoteAdded>()],
        verify: (bloc) {
          mockLocalNotesRepository.addNote(
            localNoteEntity: mockLocalNoteEntity,
          );
        },
      );

      blocTest<LocalNotesBloc, LocalNotesState>(
        'Should add note and emit [LocalNotesLoading , LocalNoteError] when AddLocalNote',
        setUp: () {
          when(mockLocalNotesRepository.addNote(
                  localNoteEntity: mockLocalNoteEntity))
              .thenAnswer((_) async => const Left('error'));
        },
        build: () => LocalNotesBloc(
          localNotesRepository: mockLocalNotesRepository,
        ),
        act: (bloc) =>
            bloc.add(AddLocalNote(localNoteEntity: mockLocalNoteEntity)),
        expect: () => [isA<LocalNotesLoading>(), isA<LocalNoteError>()],
        verify: (bloc) {
          mockLocalNotesRepository.addNote(
            localNoteEntity: mockLocalNoteEntity,
          );
        },
      );

      blocTest<LocalNotesBloc, LocalNotesState>(
        'Should add note and emit [LocalNotesLoading , GetSavedLocalNotes] when GetLocalNotes',
        setUp: () {
          when(mockLocalNotesRepository.getLocalNotes()).thenAnswer(
            (_) async => Right(
              [mockLocalNoteEntity],
            ),
          );
        },
        build: () => LocalNotesBloc(
          localNotesRepository: mockLocalNotesRepository,
        ),
        act: (bloc) => bloc.add(GetLocalNotes()),
        expect: () => [isA<LocalNotesLoading>(), isA<GetSavedLocalNotes>()],
        verify: (bloc) {
          mockLocalNotesRepository.getLocalNotes();
        },
      );

      blocTest<LocalNotesBloc, LocalNotesState>(
        'Should add note and emit [LocalNotesLoading , LocalNoteError] when GetLocalNotes',
        setUp: () {
          when(mockLocalNotesRepository.getLocalNotes())
              .thenAnswer((_) async => const Left('error'));
        },
        build: () => LocalNotesBloc(
          localNotesRepository: mockLocalNotesRepository,
        ),
        act: (bloc) => bloc.add(GetLocalNotes()),
        expect: () => [isA<LocalNotesLoading>(), isA<LocalNoteError>()],
        verify: (bloc) {
          mockLocalNotesRepository.getLocalNotes();
        },
      );

      blocTest<LocalNotesBloc, LocalNotesState>(
        'Should add note and emit [LocalNotesLoading , LocalNoteEdited] when EditLocalNote',
        setUp: () {
          when(mockLocalNotesRepository.editData(
            localNoteEntity: mockLocalNoteEntity,
            key: 'null',
          )).thenAnswer((_) async => const Right(unit));
        },
        build: () => LocalNotesBloc(
          localNotesRepository: mockLocalNotesRepository,
        ),
        act: (bloc) => bloc.add(
            EditLocalNote(localNoteEntity: mockLocalNoteEntity, key: 'null')),
        expect: () => [isA<LocalNotesLoading>(), isA<LocalNoteEdited>()],
        verify: (bloc) {
          mockLocalNotesRepository.editData(
            localNoteEntity: mockLocalNoteEntity,
            key: 'null',
          );
        },
      );

      blocTest<LocalNotesBloc, LocalNotesState>(
        'Should add note and emit [LocalNotesLoading , LocalNoteError] when EditLocalNote',
        setUp: () {
          when(mockLocalNotesRepository.editData(
            localNoteEntity: mockLocalNoteEntity,
            key: 'null',
          )).thenAnswer((_) async => const Left('error'));
        },
        build: () => LocalNotesBloc(
          localNotesRepository: mockLocalNotesRepository,
        ),
        act: (bloc) => bloc.add(
            EditLocalNote(localNoteEntity: mockLocalNoteEntity, key: 'null')),
        expect: () => [isA<LocalNotesLoading>(), isA<LocalNoteError>()],
        verify: (bloc) {
          mockLocalNotesRepository.editData(
            localNoteEntity: mockLocalNoteEntity,
            key: 'null',
          );
        },
      );

      blocTest<LocalNotesBloc, LocalNotesState>(
        'Should add note and emit [LocalNotesLoading , LocalNoteDelted] when DeleteLocalNote',
        setUp: () {
          when(mockLocalNotesRepository.deleteData(
            key: 'null',
          )).thenAnswer((_) async => const Right(unit));
        },
        build: () => LocalNotesBloc(
          localNotesRepository: mockLocalNotesRepository,
        ),
        act: (bloc) => bloc.add(const DeleteLocalNote(key: 'null')),
        expect: () => [isA<LocalNotesLoading>(), isA<LocalNoteDelted>()],
        verify: (bloc) {
          mockLocalNotesRepository.deleteData(
            key: 'null',
          );
        },
      );

      blocTest<LocalNotesBloc, LocalNotesState>(
        'Should add note and emit [LocalNotesLoading , LocalNoteError] when DeleteLocalNote',
        setUp: () {
          when(mockLocalNotesRepository.deleteData(
            key: 'null',
          )).thenAnswer((_) async => const Left('error'));
        },
        build: () => LocalNotesBloc(
          localNotesRepository: mockLocalNotesRepository,
        ),
        act: (bloc) => bloc.add(const DeleteLocalNote(key: 'null')),
        expect: () => [isA<LocalNotesLoading>(), isA<LocalNoteError>()],
        verify: (bloc) {
          mockLocalNotesRepository.deleteData(
            key: 'null',
          );
        },
      );

      tearDown(() {
        mockLocalNotesBloc.close();
      });
    },
  );
}
