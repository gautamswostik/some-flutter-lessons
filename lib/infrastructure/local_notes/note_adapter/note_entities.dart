import 'package:hive_flutter/adapters.dart';

part 'note_entities.g.dart';

@HiveType(typeId: 1)
class LocalNoteEntity extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String descripion;

  LocalNoteEntity({
    required this.title,
    required this.descripion,
  });
}
