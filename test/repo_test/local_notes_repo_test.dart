import 'package:flutter_test/flutter_test.dart';
import 'package:fluuter_boilerplate/app_setup/hive/hive_box.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/local_notes_repo.dart';
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
        'Testing get Saved Local Data success',
        () async {
          //arange
          when(mockHiveInterface.isAdapterRegistered(1))
              .thenAnswer((_) => true);
          when(mockHiveInterface.openBox<MockLocalNoteEntity>(HiveBox.notesBox))
              .thenAnswer((_) async => mockBox);
          when(mockBox.values).thenAnswer((_) => <MockLocalNoteEntity>[]);

          //act
          final data = await localNotesRepository.getLocalNotes();
          //verify
          expect(data.isRight(), true);
          verify(mockHiveInterface.openBox(HiveBox.notesBox));
        },
      );

      test(
        'Testing get Saved Local Data error',
        () async {
          //arange
          when(mockHiveInterface.openBox<MockLocalNoteEntity>(HiveBox.notesBox))
              .thenThrow(HiveError('error'));
          when(mockHiveInterface.isAdapterRegistered(1))
              .thenAnswer((_) => true);

          try {
            await localNotesRepository.getLocalNotes();
          } catch (e) {
            //verify
            expect(e, isA<HiveError>());
          }
        },
      );
      test(
        'Testing Edit Local Data success',
        () async {
          //arange
          when(mockHiveInterface.isAdapterRegistered(1))
              .thenAnswer((_) => true);
          when(mockHiveInterface.openBox<MockLocalNoteEntity>(HiveBox.notesBox))
              .thenAnswer((_) async => mockBox);
          when(mockBox.containsKey('null')).thenReturn(true);

          //act
          final data = await localNotesRepository.editData(
            key: 'null',
            localNoteEntity: mockLocalNoteEntity,
          );
          //verify
          expect(data.isRight(), true);
          verify(mockHiveInterface.openBox(HiveBox.notesBox));
        },
      );

      test(
        'Testing edit Saved Local Data error',
        () async {
          //arange
          when(mockHiveInterface.isAdapterRegistered(1))
              .thenAnswer((_) => true);
          when(mockHiveInterface.openBox<MockLocalNoteEntity>(HiveBox.notesBox))
              .thenAnswer((_) async => mockBox);
          when(mockBox.containsKey('null')).thenReturn(false);

          //act
          final data = await localNotesRepository.editData(
            key: 'null',
            localNoteEntity: mockLocalNoteEntity,
          );
          //verify
          expect(data.isLeft(), true);
          verify(mockHiveInterface.openBox(HiveBox.notesBox));
        },
      );

      test(
        'Testing edit Saved Local Data error',
        () async {
          //arange
          when(mockHiveInterface.openBox<MockLocalNoteEntity>(HiveBox.notesBox))
              .thenThrow(HiveError('error'));
          when(mockHiveInterface.isAdapterRegistered(1))
              .thenAnswer((_) => true);

          try {
            await localNotesRepository.editData(
              key: 'null',
              localNoteEntity: mockLocalNoteEntity,
            );
          } catch (e) {
            //verify
            expect(e, isA<HiveError>());
          }
        },
      );
      test(
        'Testing delete Local Data success',
        () async {
          //arange
          when(mockHiveInterface.isAdapterRegistered(1))
              .thenAnswer((_) => true);
          when(mockHiveInterface.openBox<MockLocalNoteEntity>(HiveBox.notesBox))
              .thenAnswer((_) async => mockBox);
          when(mockBox.containsKey('null')).thenReturn(true);

          //act
          final data = await localNotesRepository.deleteData(
            key: 'null',
          );
          //verify
          expect(data.isRight(), true);
          verify(mockHiveInterface.openBox(HiveBox.notesBox));
        },
      );

      test(
        'Testing delete Saved Local Data error',
        () async {
          //arange
          when(mockHiveInterface.isAdapterRegistered(1))
              .thenAnswer((_) => true);
          when(mockHiveInterface.openBox<MockLocalNoteEntity>(HiveBox.notesBox))
              .thenAnswer((_) async => mockBox);
          when(mockBox.containsKey('null')).thenReturn(false);

          //act
          final data = await localNotesRepository.deleteData(
            key: 'null',
          );
          //verify
          expect(data.isLeft(), true);
          verify(mockHiveInterface.openBox(HiveBox.notesBox));
        },
      );

      test(
        'Testing delete Saved Local Data error',
        () async {
          //arange
          when(mockHiveInterface.openBox<MockLocalNoteEntity>(HiveBox.notesBox))
              .thenThrow(HiveError('error'));
          when(mockHiveInterface.isAdapterRegistered(1))
              .thenAnswer((_) => true);

          try {
            await localNotesRepository.deleteData(
              key: 'null',
            );
          } catch (e) {
            //verify
            expect(e, isA<HiveError>());
          }
        },
      );
    },
  );
}
