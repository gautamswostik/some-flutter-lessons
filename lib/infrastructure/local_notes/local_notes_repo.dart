import 'package:dartz/dartz.dart';
import 'package:fluuter_boilerplate/app_setup/hive/hive_box.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/note_adapter/note_entities.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

abstract class ILocalNotesRepository {
  Future<Either<String, Unit>> addNote(
      {required LocalNoteEntity localNoteEntity});
  Future<Either<String, List<LocalNoteEntity>>> getLocalNotes();
  Future<Either<String, Unit>> editData(
      {required dynamic key, required LocalNoteEntity localNoteEntity});
  Future<Either<String, Unit>> deleteData({required dynamic key});
}

class LocalNotesRepository extends ILocalNotesRepository {
  LocalNotesRepository({
    required this.hive,
    required this.uuid,
  });
  final HiveInterface hive;
  final Uuid uuid;

  @override
  Future<Either<String, Unit>> addNote(
      {required LocalNoteEntity localNoteEntity}) async {
    checkAdpRegistered();
    try {
      final notes = await hive.openBox<LocalNoteEntity>(HiveBox.notesBox);
      await notes.put(uuid.v4(), localNoteEntity);
      return const Right(unit);
    } on HiveError catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, List<LocalNoteEntity>>> getLocalNotes() async {
    checkAdpRegistered();
    try {
      final notes = await hive.openBox<LocalNoteEntity>(HiveBox.notesBox);
      List<LocalNoteEntity> savedNotes = notes.values.toList();
      return Right(savedNotes);
    } on HiveError catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, Unit>> editData(
      {required dynamic key, required LocalNoteEntity localNoteEntity}) async {
    checkAdpRegistered();

    try {
      final notes = await hive.openBox<LocalNoteEntity>(HiveBox.notesBox);
      if (notes.containsKey(key)) {
        await notes.put(key, localNoteEntity);
        return const Right(unit);
      } else {
        return const Left('Key Not found');
      }
    } on HiveError catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, Unit>> deleteData({required dynamic key}) async {
    checkAdpRegistered();
    try {
      final notes = await hive.openBox<LocalNoteEntity>(HiveBox.notesBox);
      if (notes.containsKey(key)) {
        await notes.delete(key);
        return const Right(unit);
      } else {
        return const Left('Key Not found');
      }
    } on HiveError catch (e) {
      return Left(e.message);
    }
  }

  void checkAdpRegistered() {
    if (!hive.isAdapterRegistered(1)) {
      hive.registerAdapter(LocalNoteEntityAdapter());
    }
  }
}
