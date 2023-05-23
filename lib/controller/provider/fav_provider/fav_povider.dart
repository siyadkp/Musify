import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../model/model.dart';

class FavNotifier extends ChangeNotifier {
  List<SongDbModel> favSongs = [];
  FavNotifier() {
    favAllSongsFetching();
  }

  FavoriteDataBase favoriteDb = FavoriteDataBase();

  favAction(SongDbModel song, BuildContext context) {
    if (favChecking(song)) {
      favoriteDb.favDelete(song.id);
      const remove = SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(222, 38, 46, 67),
        content: Center(
          child: Text(
            'Song Removed In Favorate List',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white70),
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(remove);
    } else {
      favoriteDb.favAdd(song.id, song);
      const add = SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(222, 38, 46, 67),
        content: Center(
          child: Text(
            'Song Added In Favorate List',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white70),
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(add);
    }
    favAllSongsFetching();
    notifyListeners();
  }

  sampleee() {
    notifyListeners();
  }

  favAllSongsFetching() {
    favSongs.clear();
    favSongs.addAll(favoriteDb.favGet().reversed.toSet().toList());
  }

  bool favChecking(SongDbModel song) {
    return favoriteDb.favSongChecking(song);
  }
}

class FavoriteDataBase {
  static final favoritedb = Hive.box<SongDbModel>('FavoriteDB');
  static ValueNotifier<List<SongDbModel>> favoriteSongsNotifer =
      ValueNotifier([]);

  favSongChecking(SongDbModel song) {
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

  favAdd(int songid, SongDbModel song) async {
    bool condition = favSongChecking(song);
    if (condition == false) {
      favoritedb.put(songid, song);
      // favGet();
    }
  }

  List<SongDbModel> favGet() {
    List<SongDbModel> favResul;
    favResul = favoritedb.values.toList();
    favoriteSongsNotifer.value.clear();
    favoriteSongsNotifer.value.addAll(favResul);
    return favResul;
  }

  favDelete(songid) {
    favoritedb.delete(songid);
  }
}
