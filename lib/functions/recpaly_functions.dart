import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myapp/functions/allsong_db_functions.dart';

class GetRecentlyPlayed {
  static ValueNotifier recentSongNotifier = ValueNotifier([]);
  static List<int> recentlyplayed = [];

  static Future<void> addRecentlyPlayed(int id) async {
    final recentDB = await Hive.openBox<int>('recentSongNotifier');
    await recentDB.add(id);
    getRecentlySongs();
  }

  static Future<void> getRecentlySongs() async {
    List recentSongs = [];
    final recentDB = Hive.box<int>('recentSongNotifier');
    recentlyplayed.clear();
    recentlyplayed = recentDB.values.toSet().toList();
    recentSongNotifier.value.clear();
    for (int i = 0; i < resulted.length; i++) {
      for (int j = 0; j < recentlyplayed.length; j++) {
        if (resulted[i].id == recentlyplayed[j]) {
          recentSongs.add(resulted[i]);
        }
      }
    }
    recentSongNotifier.value.addAll(recentSongs);
  }

  // static Future<void> displayRecentlySongs() async {
  //   final recentDB = await Hive.openBox('recentSongNotifier');
  //   final recentSongItems = recentDB.values.toList();
  //   recentSongNotifier.value.clear();
  //   recentlyplayed.clear();
  //   for (int i = 0; i < recentSongItems.length; i++) {
  //     for (int j = 0; j < resulted.length; j++) {
  //       if (recentSongItems[i] == resulted[j]) {
  //         recentSongNotifier.value.add(resulted[j]);
  //         recentlyplayed.add(resulted[j]);
  //       }
  //     }
  //   }
  // }
}
