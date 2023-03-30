import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/model/model.dart';

List<SongDbModel> resulted = [];

class SongModelFunctions {
  final allsongDb = Hive.openBox<SongDbModel>('songs');

  static addAllsong(SongDbModel value) {
    final allsongDb = Hive.box<SongDbModel>('songs');
    allsongDb.add(value);
  }

  static getAllsong() {
    final allsongDb = Hive.box<SongDbModel>('songs');
    resulted.clear();
    resulted = allsongDb.values.toList();
  }
}
