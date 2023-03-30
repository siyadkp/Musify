// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayermodelAdapter extends TypeAdapter<Playermodel> {
  @override
  final int typeId = 1;

  @override
  Playermodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Playermodel(
      index: fields[0] as int,
      song: fields[1] as SongDbModel,
      playlistName: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Playermodel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.song)
      ..writeByte(2)
      ..write(obj.playlistName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayermodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SongDbModelAdapter extends TypeAdapter<SongDbModel> {
  @override
  final int typeId = 2;

  @override
  SongDbModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongDbModel(
      id: fields[0] as int,
      data: fields[1] as String,
      uri: fields[2] as String,
      displayName: fields[3] as String,
      displayNameWOExt: fields[4] as String,
      artist: fields[5] as String,
      artistId: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SongDbModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.uri)
      ..writeByte(3)
      ..write(obj.displayName)
      ..writeByte(4)
      ..write(obj.displayNameWOExt)
      ..writeByte(5)
      ..write(obj.artist)
      ..writeByte(6)
      ..write(obj.artistId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongDbModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
