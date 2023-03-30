import 'package:hive_flutter/hive_flutter.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class Playermodel {
  @HiveField(0)
  int index;
  @HiveField(1)
  SongDbModel song;
  @HiveField(2)
  String playlistName;

  Playermodel(
      {required this.index, required this.song, required this.playlistName});
}

@HiveType(typeId: 2)
class SongDbModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String data;
  @HiveField(2)
  String uri;
  @HiveField(3)
  String displayName;
  @HiveField(4)
  String displayNameWOExt;
  @HiveField(5)
  String artist;
  @HiveField(6)
  int artistId;

  SongDbModel({
    required this.id,
    required this.data,
    required this.uri,
    required this.displayName,
    required this.displayNameWOExt,
    required this.artist,
    required this.artistId,
  });

  void addAll(List<SongDbModel> mostlyResult) {}

  void clear() {}
}
