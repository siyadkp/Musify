import 'package:hive_flutter/adapters.dart';

import '../playlist_all_songs.dart';

class PlaylistDataBase {
  static final playlistDb = Hive.box('playlistDb');

  Future<void> addPlaylist(String playlistName) async {
    await playlistDb.add(playlistName);
  }

  List getAllPlaylist() {
    return playlistDb.values.toList();
  }

  Future<void> deletePlaylist(int index) async {
    await playlistDb.deleteAt(index);
  }

  Future<void> editList(int index, String value, String oldName) async {
    PlaylistSongDataBase playlistSongDataBase = PlaylistSongDataBase();
    playlistDb.putAt(index, value);
    getAllPlaylist();
    playlistSongDataBase.editPlaylist(value, index, oldName);
  }
}
