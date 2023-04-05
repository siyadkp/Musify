import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:myapp/model/model.dart';

List<SongDbModel> playlistResult = [];

class PlaylistSongDB {
  static final playlistSongDb = Hive.box<Playermodel>('Playlist_SongDB');
  static ValueNotifier<List<Playermodel>> playlistSongsNotifer =
      ValueNotifier([]);

  static playlistSongChecking(SongDbModel song) {
    bool condition = false;
    for (var element in playlistResult) {
      if (element.id == song.id) {
        return condition = true;
      }
    }
    return condition;
  }

  static playlistSongAdd(
      String playlistName, Playermodel song, int songIndex) async {
    playlistSongDb.put(songIndex, song);
    playlistSongGet(playlistName);
  }

  static playlistSongGet(String playlistName) {
    List<Playermodel> playlistValue = [];
    playlistResult.clear();
    playlistSongsNotifer.value.clear();
    playlistValue = playlistSongDb.values.toList();
    for (var element in playlistValue) {
      if (element.playlistName == playlistName) {
        playlistSongsNotifer.value.add(element);
        playlistResult.add(element.song);
      }
    }
    playlistSongsNotifer.notifyListeners();
  }

  static playlisSongDelete(String playlistName, songIndex) {
    playlistSongDb.delete(songIndex);
    playlistSongGet(playlistName);
  }

  static editPlaylist(newPlaylistName, playlistIndex, oldName) {
    List<Playermodel> playlistValue = playlistSongDb.values.toList();
    for (var element in playlistValue) {
      if (element.playlistName == oldName) {
        Playermodel value = Playermodel(
            index: playlistIndex,
            song: element.song,
            playlistName: newPlaylistName);
        playlistSongDb.add(value);
      }
    }
  }
}
