import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/functions/allsong_db_functions.dart';
import 'package:myapp/model/model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostlyFunctions {
  static ValueNotifier<List<SongDbModel>> mostNotifier = ValueNotifier([]);
  static List<dynamic> mostlyResult = [];
  static List<SongModel> mostlyList = [];

  static Future<void> addMostly(item) async {
    final mostDB = await Hive.openBox('most_db');
    mostDB.add(item);
    getMostly();
  }

  static Future<void> getMostly() async {
    displayMostly();
  }

  static Future<List> displayMostly() async {
    final mostDB = await Hive.openBox('most_db');
    final mostlyplayedList = mostDB.values.toList();
    final most = mostDB.values.toSet().toList();

    mostNotifier.value.clear();
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
            mostNotifier.value.add(resulted[m]);
            mostlyResult.add(resulted[m]);
          }
        }
        count = 0;
      }
    }
    return mostlyResult;
  }
}
