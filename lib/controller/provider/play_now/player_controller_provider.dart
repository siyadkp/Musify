import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:myapp/view/pages/playnow/playnow.dart';
import '../../../view/pages/playnow/widget/slider.dart';
import '../../get_allsongs_controler.dart';
import 'play_now.dart';

// Duration duration = const Duration();
// Duration position = const Duration();

class PlayerControllerNotifier with ChangeNotifier {
  late StreamSubscription<Duration> _positionSubscription;

  int large = 0;
  bool firstsong = false;
  bool lastsong = false;

  shuffling() {
    isshuffle == false
        ? Getallsongs.audioPlayer.setShuffleModeEnabled(true)
        : Getallsongs.audioPlayer.setShuffleModeEnabled(false);
    notifyListeners();
  }

  repeatPlay() {
    Getallsongs.audioPlayer.loopMode == LoopMode.one
        ? Getallsongs.audioPlayer.setLoopMode(LoopMode.all)
        : Getallsongs.audioPlayer.setLoopMode(LoopMode.one);
    notifyListeners();
  }

  // nextSong() {
  //   if (Getallsongs.audioPlayer.hasPrevious) {
  //     Getallsongs.audioPlayer.seekToPrevious();
  //   }
  // }

  seekToNext() {
    try {
      if (Getallsongs.audioPlayer.hasNext) {
        Getallsongs.audioPlayer.seekToNext();
      }
      notifyListeners();
    } catch (e) {
      print('Error occurred during seekToNext: $e');
    }
  }

  seekToPrev() {
    if (firstsong) {
      Getallsongs.currentindexgetallsongs--;
      if (Getallsongs.currentindexgetallsongs < 0) {
        Getallsongs.currentindexgetallsongs = 0;
        currentindex = 0;
      }
    } else {
      if (Getallsongs.audioPlayer.hasPrevious) {
        Getallsongs.audioPlayer.seekToPrevious();
        currentindex--;
      }
    }
    notifyListeners();
    return currentindex;
  }

  pauseAndplay() {
    if (Getallsongs.audioPlayer.playing) {
      Getallsongs.audioPlayer.pause();
      isplaying = false;
    } else {
      Getallsongs.audioPlayer.play();
      isplaying = true;
    }
    notifyListeners();
    return isplaying;
  }

  chagetoseconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    Getallsongs.audioPlayer.seek(duration);
    notifyListeners();
  }
}
