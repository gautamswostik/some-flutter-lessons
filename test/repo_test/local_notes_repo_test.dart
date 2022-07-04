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
        'Testing Save Local Note',
        () async {
          //arange
          when(mockHiveInterface.openBox<MockLocalNoteEntity>(HiveBox.notesBox))
              .thenAnswer((_) async => mockBox);
          when(mockUuid.v4()).thenAnswer((_) => 'uuid');

          //act
          await localNotesRepository.addNote(
              localNoteEntity: mockLocalNoteEntity);
          //verify
          verify(mockBox.put('uuid', mockLocalNoteEntity));
          verify(mockHiveInterface.openBox(HiveBox.notesBox));
        },
      );

      test(
        'Testing get Saved Local Data',
        () async {
          //arange
          when(mockHiveInterface.openBox<MockLocalNoteEntity>(HiveBox.notesBox))
              .thenAnswer((_) async => mockBox);
          when(mockBox.values).thenAnswer((_) => <MockLocalNoteEntity>[]);

          //act
          List<LocalNoteEntity> data =
              await localNotesRepository.getLocalNotes();
          //verify
          expect(data, <MockLocalNoteEntity>[]);
          verify(mockHiveInterface.openBox(HiveBox.notesBox));
        },
      );
    },
  );
}
