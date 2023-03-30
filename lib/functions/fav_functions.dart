import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:myapp/model/model.dart';

class FavoriteDB {
  static final favoritedb = Hive.box<SongDbModel>('FavoriteDB');
  static ValueNotifier<List<SongDbModel>> favoriteSongsNotifer =
      ValueNotifier([]);

  static favSongChecking(SongDbModel song) {
    List<SongDbModel> favResul = [];
    bool condition = false;
    favResul = favoritedb.values.toList();
    for (var element in favResul) {
      if (element.id == (song.id)) {
        return condition = true;
      }
    }
    return condition;
  }

  static favAdd(int songid, SongDbModel song) async {
    bool condition = favSongChecking(song);
    if (condition == false) {
      favoritedb.put(songid, song);
      favGet();
    }
  }

  static favGet() {
    List<SongDbModel> favResul;
    favResul = favoritedb.values.toList();
    favoriteSongsNotifer.value.clear();
    favoriteSongsNotifer.value.addAll(favResul);
    return favResul;
  }

  static favDelete(songid) {
    favoritedb.delete(songid);
    favGet();
  }
}
