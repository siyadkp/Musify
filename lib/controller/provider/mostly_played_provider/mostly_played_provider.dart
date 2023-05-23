import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../model/model.dart';
import '../../functions/allsong_db_functions.dart';

class MostlyNotifier with ChangeNotifier {
  List<SongDbModel> mostlyResult = [];
  final mostDB = Hive.box('most_db');

  Future<void> addToMostly(item) async {
    mostDB.add(item);
    displayToMostly();
  }

  Future<List> displayToMostly() async {
    List<SongDbModel> mostlySongList = [];
    mostlySongList.clear();
    mostlyResult.clear();
    final mostDB = await Hive.openBox('most_db');
    final mostlyplayedList = mostDB.values.toList();
    final most = mostDB.values.toSet().toList();

    int count = 0;
    for (int i = 0; i < mostlyplayedList.length; i++) {
      for (int j = 0; j < most.length; j++) {
        if (mostlyplayedList[i] == most[j]) {
          count++;
        }
      }
      if (count > 4) {
        for (int m = 0; m < resulted.length; m++) {
          if (mostlyplayedList[i] == resulted[m].id) {
            mostlySongList.add(resulted[m]);
          }
        }
        count = 0;
      }
    }
    mostlyResult = mostlySongList.reversed.toSet().toList();
    notifyListeners();
    return mostlyResult;
  }
}
