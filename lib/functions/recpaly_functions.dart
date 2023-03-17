import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myapp/allmusic/allmusic.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GetRecentlyPlayed {
  static ValueNotifier<List<SongModel>> recentSongNotifier = ValueNotifier([]);
  static List recentlyplayed = [];

  static Future<void> addRecentlyPlayed(Songid) async {
    final recentDB = await Hive.openBox('recentSongNotifier');
    await recentDB.add(Songid);
    getRecentlySongs();
    recentSongNotifier.notifyListeners();
  }

  static Future<void> getRecentlySongs() async {
    final recentDB = await Hive.openBox('recentSongNotifier');
    // recentlyplayed = await recentDB.values.toList();
    displayRecentlySongs();
    recentSongNotifier.notifyListeners();
  }

  static Future<void> displayRecentlySongs() async {
    final recentDB = await Hive.openBox('recentSongNotifier');
    final recentSongItems = recentDB.values.toList();
    recentSongNotifier.value.clear();
    recentlyplayed.clear();
    for (int i = 0; i < recentSongItems.length; i++) {
      for (int j = 0; j < startsong.length; j++) {
        if (recentSongItems[i] == startsong[j].id) {
          recentSongNotifier.value.add(startsong[j]);
          recentlyplayed.add(startsong[j]);
        }
      }
    }
  }
}
