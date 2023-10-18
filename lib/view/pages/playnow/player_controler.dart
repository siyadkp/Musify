import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:myapp/controller/get_allsongs_controler.dart';
import 'package:myapp/controller/provider/play_now/player_controller_provider.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/view/pages/playnow/playnow.dart';
import 'package:provider/provider.dart';

class Playercontroler extends StatelessWidget {
  const Playercontroler(
      {super.key,
      required this.count,
      required this.lastsong,
      required this.songModel});
  final int count;
  final bool lastsong;
  final List<SongDbModel> songModel;

  // bool isplaying = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerControllerNotifier>(
        builder: (context, playerControllerNotifier, _) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {
                playerControllerNotifier.shuffling();
              },
              icon: StreamBuilder<bool>(
                stream: Getallsongs.audioPlayer.shuffleModeEnabledStream,
                builder: (context, snapshot) {
                  isshuffle = snapshot.data ?? false;
                  if (isshuffle) {
                    return const Icon(
                      Icons.shuffle_on_outlined,
                      color: Colors.white38,
                    );
                  } else {
                    return const Icon(
                      Icons.shuffle,
                      color: Colors.white60,
                    );
                  }
                },
              )),
          IconButton(
              onPressed: () => playerControllerNotifier.seekToPrev(),
              icon: const Icon(
                Icons.skip_previous,
                size: 30,
                color: Colors.white,
              )),
          CircleAvatar(
            backgroundColor: Colors.white24,
            radius: 30,
            child: Center(
              child: IconButton(
                onPressed: () {
                  playerControllerNotifier.pauseAndplay();
                },
                icon: StreamBuilder<bool>(
                  stream: Getallsongs.audioPlayer.playingStream,
                  builder: (context, snapshot) {
                    bool? playingStage = snapshot.data;
                    if (playingStage != null && playingStage) {
                      return const Icon(
                        Icons.pause,
                        color: Colors.white,
                        size: 30,
                      );
                    } else {
                      return const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      );
                    }
                  },
                ),
                //  Icon(
                //   !playerControllerNotifier.isplaying
                //       ? Icons.pause
                //       : Icons.play_arrow,
                //   color: Colors.white,
                //   size: 30,
                // ),
              ),
            ),
          ),
          lastsong
              ? const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.skip_next,
                    size: 30,
                    color: Colors.white,
                  ))
              : IconButton(
                  onPressed: () {
                    playerControllerNotifier.seekToNext();
                  },
                  icon: const Icon(
                    Icons.skip_next,
                    size: 30,
                    color: Colors.white,
                  )),
          IconButton(
              onPressed: () {
                playerControllerNotifier.repeatPlay();
              },
              icon: StreamBuilder<LoopMode>(
                stream: Getallsongs.audioPlayer.loopModeStream,
                builder: (context, snapshot) {
                  final loopmode = snapshot.data;
                  if (LoopMode.one == loopmode) {
                    return const Icon(
                      Icons.repeat_on_outlined,
                      color: Colors.white38,
                    );
                  } else {
                    return const Icon(
                      Icons.repeat,
                      color: Colors.white60,
                    );
                  }
                },
              )),
        ],
      );
    });
  }
}
