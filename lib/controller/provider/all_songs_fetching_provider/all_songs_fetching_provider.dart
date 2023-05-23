import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../model/model.dart';

class AllSongFetchingInExternalNotifier with ChangeNotifier {
  final audioquery = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();
  AllSongFetchingInExternalNotifier() {
    final allsongDb = Hive.box<SongDbModel>('songs');
    allsongDb.clear();
    requestPermission();
  }

  Future<void> requestPermission() async {
    try {
      bool status = await audioquery.permissionsStatus();
      if (!status) {
        await audioquery.permissionsRequest();
        await Permission.storage.request();
      }
    } catch (e) {
      // Handle the exception here
      print('Error requesting permission: $e');
      // You can show an error message or perform any necessary actions
    }
  }
}
