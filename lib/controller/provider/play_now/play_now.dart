import 'package:flutter/material.dart';
import '../../get_allsongs_controler.dart';

class PlayNowNotifier with ChangeNotifier {
  samplee() {
    notifyListeners();
  }

  void changeToSeconds(int secondas) {
    Duration duration = Duration(seconds: secondas);
    Getallsongs.audioPlayer.seek(duration);
    notifyListeners();
  }
}
