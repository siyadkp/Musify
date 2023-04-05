import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapp/functions/playlist/song_add_to_playlist.dart';

class PlaylistDB {
  static ValueNotifier playlistNotifiier = ValueNotifier([]);
  static final playlistDb = Hive.box('playlistDb');

  static playlistNameChecking(name) {
    List playResult = [];

    playResult = playlistDb.values.toList();
    if (playResult.contains(name)) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> addPlaylist(String playlistName) async {
    final playlistDb = Hive.box('playlistDb');
    await playlistDb.add(playlistName);
    getAllPlaylist();
  }

  static Future getAllPlaylist() async {
    final playlistDb = Hive.box('playlistDb');
    final playlistData = playlistDb.values.toList();
    playlistNotifiier.value.clear();
    playlistNotifiier.value.addAll(playlistData);
    playlistNotifiier.notifyListeners();
  }

  static Future<void> deletePlaylist(int index) async {
    final playlistDb = Hive.box('playlistDb');
    await playlistDb.deleteAt(index);
    getAllPlaylist();
  }

  static Future<void> editList(int index, String value, String oldName) async {
    final playlistDb = Hive.box('playlistDb');
    playlistDb.putAt(index, value);
    getAllPlaylist();
    PlaylistSongDB.editPlaylist(value, index, oldName);
  }
}
