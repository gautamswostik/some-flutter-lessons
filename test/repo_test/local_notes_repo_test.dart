import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluuter_boilerplate/app_setup/hive/hive_box.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/local_notes_repo.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/note_adapter/note_entities.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

import '../mocks/app_mocks.mocks.dart';

void main() {
  group(
    'Testing Local Notes Repository',
    () {
      late LocalNotesRepository localNotesRepository;
      late HiveInterface mockHiveInterface;
      late Box<MockLocalNoteEntity> mockBox;
      late Uuid mockUuid;
      late MockLocalNoteEntity mockLocalNoteEntity;
      setUp(() {
        mockHiveInterface = MockHiveInterface();
        mockUuid = MockUuid();
        mockBox = MockBox();
        localNotesRepository = LocalNotesRepository(
          hive: mockHiveInterface,
          uuid: mockUuid,
        );
        mockLocalNoteEntity = MockLocalNoteEntity();
      });

      test(
        'Testing Save Local Note Success',
        () async {
          //arrange
          when(mockHiveInterface.isAdapterRegistered(1))
              .thenAnswer((_) => true);
          when(mockHiveInterface.openBox<MockLocalNoteEntity>(HiveBox.notesBox))
              .thenAnswer((_) async => mockBox);
          when(mockUuid.v4()).thenAnswer((_) => 'uuid');
          //act
          final data = await localNotesRepository.addNote(
              localNoteEntity: mockLocalNoteEntity);
          expect(data.isRight(), true);
          //varify
          verify(mockBox.put('uuid', mockLocalNoteEntity));
          verify(mockHiveInterface.openBox(HiveBox.notesBox));
        },
      );

      test(
        'Testing Save Local Note Error',
        () async {
          //arange
          when(mockHiveInterface.openBox<MockLocalNoteEntity>(HiveBox.notesBox))
              .thenThrow(HiveError('error'));
          when(mockHiveInterface.isAdapterRegistered(1))
              .thenAnswer((_) => true);
          when(mockUuid.v4()).thenAnswer((_) => 'uuid');
          //act
          try {
            await localNotesRepository.addNote(
                localNoteEntity: mockLocalNoteEntity);
          } catch (e) {
            //verify
            expect(e, isA<HiveError>());
          }
        },
      );

      test(
        'Testing Get Local Note Success',
        () async {
          //arrange
          when(mockHiveInterface.isAdapterRegistered(1))
              .thenAnswer((_) => true);
          when(mockHiveInterface.openBox<MockLocalNoteEntity>(HiveBox.notesBox))
              .thenAnswer((_) async => mockBox);
          when(mockUuid.v4()).thenAnswer((_) => 'uuid');

          //act
          final data = await localNotesRepository.addNote(
              localNoteEntity: mockLocalNoteEntity);
          expect(data.isRight(), true);
          //varify
          verify(mockBox.put('uuid', mockLocalNoteEntity));
          verify(mockHiveInterface.openBox(HiveBox.notesBox));
        },
      );
    },
  );
}
