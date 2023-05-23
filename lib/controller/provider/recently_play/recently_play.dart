import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../model/model.dart';
import '../../functions/allsong_db_functions.dart';

class RecentlyPlayedNotifier with ChangeNotifier {
  List<int> recentlyplayed = [];
  List<SongDbModel> recentSongsResult = [];
  RecentlyPlayedNotifier() {
    getRecentlySongs();
  }
  Future<void> addRecentlyPlayed(int id) async {
    final recentDB = await Hive.openBox<int>('recentSongNotifier');
    recentDB.delete(id);
    await recentDB.put(id, id);
    getRecentlySongs();
  }

  Future<void> getRecentlySongs() async {
    List<SongDbModel> recentSongsList = [];
    final recentDB = Hive.box<int>('recentSongNotifier');
    recentSongsList.clear();
    recentlyplayed.clear();
    recentSongsResult.clear();
    recentlyplayed = recentDB.values.toSet().toList();
    for (int i = 0; i < resulted.length; i++) {
      for (int j = 0; j < recentlyplayed.length; j++) {
        if (resulted[i].id == recentlyplayed[j]) {
          recentSongsList.add(resulted[i]);
          break;
        }
      }
    }
    recentSongsResult.addAll(recentSongsList.reversed.toSet());
    notifyListeners();
  }
}
