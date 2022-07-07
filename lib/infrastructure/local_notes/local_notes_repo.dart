import 'package:fluuter_boilerplate/app_setup/hive/hive_box.dart';
import 'package:fluuter_boilerplate/infrastructure/local_notes/note_adapter/note_entities.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

abstract class ILocalNotesRepository {
  Future<void> addNote({required LocalNoteEntity localNoteEntity});
  Future<List<LocalNoteEntity>> getLocalNotes();
  Future<void> editData(
      {required dynamic key, required LocalNoteEntity localNoteEntity});
  Future<void> deleteData({required dynamic key});
}

class LocalNotesRepository extends ILocalNotesRepository {
  LocalNotesRepository({
    required this.hive,
    required this.uuid,
  });
  final HiveInterface hive;
  final Uuid uuid;

  @override
  Future<void> addNote({required LocalNoteEntity localNoteEntity}) async {
    checkAdpRegistered();
    final notes = await hive.openBox<LocalNoteEntity>(HiveBox.notesBox);
    await notes.put(uuid.v4(), localNoteEntity);
  }

  @override
  Future<List<LocalNoteEntity>> getLocalNotes() async {
    checkAdpRegistered();
    final notes = await hive.openBox<LocalNoteEntity>(HiveBox.notesBox);
    List<LocalNoteEntity> savedNotes = notes.values.toList();
    return savedNotes;
  }

  @override
  Future<void> editData(
      {required dynamic key, required LocalNoteEntity localNoteEntity}) async {
    checkAdpRegistered();
    final notes = await hive.openBox<LocalNoteEntity>(HiveBox.notesBox);
    if (notes.containsKey(key)) {
      await notes.put(key, localNoteEntity);
    } else {
      throw Exception('Key Not found');
    }
  }

  @override
  Future<void> deleteData({required dynamic key}) async {
    checkAdpRegistered();
    final notes = await hive.openBox<LocalNoteEntity>(HiveBox.notesBox);
    if (notes.containsKey(key)) {
      await notes.delete(key);
    } else {
      throw Exception('Key Not found');
    }
  }

  void checkAdpRegistered() {
    if (!hive.isAdapterRegistered(1)) {
      hive.registerAdapter(LocalNoteEntityAdapter());
    }
  }
}
