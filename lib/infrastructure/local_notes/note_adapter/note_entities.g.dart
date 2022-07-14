// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_entities.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalNoteEntityAdapter extends TypeAdapter<LocalNoteEntity> {
  @override
  final int typeId = 1;

  @override
  LocalNoteEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalNoteEntity(
      title: fields[0] as String,
      descripion: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocalNoteEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.descripion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalNoteEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
