import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../model/model.dart';

class PlaylistAllSongsDisplayNotifier extends ChangeNotifier {
  List<Playermodel> playlistResult = [];
  List<SongDbModel> playlistSongModelsong = [];

  PlaylistSongDataBase playlistSongDataBase = PlaylistSongDataBase();
  songAddingToPlaylist(
      String playlistName, song, songIndex, BuildContext context) {
    playlistSongDataBase.playlistSongAdd(playlistName, song, songIndex);
    playlistSongFetching(playlistName);
    const addsongplaylistsnake = SnackBar(
        backgroundColor: Color.fromARGB(222, 38, 46, 67),
        duration: Duration(seconds: 1),
        content: Center(child: Text('Music Added In Playlist')));
    ScaffoldMessenger.of(context).showSnackBar(addsongplaylistsnake);
    notifyListeners();
  }

  Future<dynamic> deleteSongInPlaylistHelper(
      BuildContext context, int index, String playlistName) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 52, 6, 105),
          title: const Text(
            'Delete Playlist',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this song?',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No',
                  style: TextStyle(
                    color: Colors.purpleAccent,
                  )),
            ),
            TextButton(
              onPressed: () {
                _deleteSongInPlaylist(playlistName, index, context);
                Navigator.pop(context);
                const snackBar = SnackBar(
                  backgroundColor: Colors.black,
                  content: Text(
                    'Song is deleted',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: Duration(milliseconds: 350),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Text('Yes',
                  style: TextStyle(
                    color: Colors.purpleAccent,
                  )),
            ),
          ],
        );
      },
    );
  }

  _deleteSongInPlaylist(String playlistName, int index, BuildContext context) {
    playlistSongDataBase.playlisSongDelete(playlistName, index);
    playlistSongFetching(playlistName);
    const removesongplaylistsnake = SnackBar(
        backgroundColor: Color.fromARGB(222, 38, 46, 67),
        duration: Duration(seconds: 1),
        content: Center(child: Text('Music Removed In Playlist')));
    ScaffoldMessenger.of(context).showSnackBar(removesongplaylistsnake);
    notifyListeners();
  }

  playlistSongFetching(String playlistName) {
    List<Playermodel> playlistValue = [];
    playlistResult.clear();
    playlistSongModelsong.clear();
    playlistValue = playlistSongDataBase.playlistSongGet();
    for (var element in playlistValue) {
      if (element.playlistName == playlistName) {
        playlistResult.add(element);
        playlistSongModelsong.add(element.song);
      }
    }
  }

  playlistSongChecking(song) {
    bool condition = false;
    for (var element in playlistResult) {
      if (element.song.id == song.id) {
        return condition = true;
      }
    }
    return condition;
  }
}

class PlaylistSongDataBase {
  final playlistSongDb = Hive.box<Playermodel>('Playlist_SongDB');

  playlistSongAdd(String playlistName, Playermodel song, int songIndex) async {
    playlistSongDb.put(songIndex, song);
  }

  playlistSongGet() {
    return playlistSongDb.values.toList();
  }

  playlisSongDelete(String playlistName, songIndex) {
    playlistSongDb.delete(songIndex);
  }

  editPlaylist(newPlaylistName, playlistIndex, oldName) {
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
