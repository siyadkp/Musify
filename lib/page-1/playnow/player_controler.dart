import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:myapp/controller/get_allsongs_controler.dart';
import 'package:myapp/model/model.dart';

class Playercontroler extends StatefulWidget {
  const Playercontroler(
      {super.key,
      required this.count,
      required this.firstsong,
      required this.lastsong,
      required this.songModel});
  final int count;
  final bool firstsong;
  final bool lastsong;
  final SongDbModel songModel;

  @override
  State<Playercontroler> createState() => _PlayercontrolerState();
}

class _PlayercontrolerState extends State<Playercontroler> {
  bool isplaying = true;
  bool isrepeat = false;
  bool isshuffle = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                isshuffle == false
                    ? Getallsongs.audioPlayer.setShuffleModeEnabled(true)
                    : Getallsongs.audioPlayer.setShuffleModeEnabled(false);
              });
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
        widget.firstsong
            ? IconButton(
                onPressed: () {
                  setState(() {
                    Getallsongs.currentindexgetallsongs--;
                    if (Getallsongs.currentindexgetallsongs < 0) {
                      Getallsongs.currentindexgetallsongs = 0;
                    }
                  });
                },
                icon: const Icon(
                  Icons.skip_previous,
                  size: 30,
                  color: Colors.white,
                ))
            : IconButton(
                onPressed: () {
                  if (Getallsongs.audioPlayer.hasPrevious) {
                    Getallsongs.audioPlayer.seekToPrevious();
                  }
                },
                icon: const Icon(
                  Icons.skip_previous,
                  size: 30,
                  color: Colors.white,
                )),
        CircleAvatar(
          backgroundColor: Colors.white24,
          radius: 30,
          child: IconButton(
              onPressed: () {
                setState(() {
                  isplaying = !isplaying;
                });
                if (Getallsongs.audioPlayer.playing) {
                  Getallsongs.audioPlayer.pause();
                } else {
                  Getallsongs.audioPlayer.play();
                }
              },
              icon: Icon(
                isplaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 30,
              )),
        ),
        widget.lastsong
            ? const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.skip_next,
                  size: 30,
                  color: Colors.white,
                ))
            : IconButton(
                onPressed: () {
                  if (Getallsongs.audioPlayer.hasNext) {
                    Getallsongs.audioPlayer.seekToNext();
                  }
                },
                icon: const Icon(
                  Icons.skip_next,
                  size: 30,
                  color: Colors.white,
                )),
        IconButton(
            onPressed: () {
              Getallsongs.audioPlayer.loopMode == LoopMode.one
                  ? Getallsongs.audioPlayer.setLoopMode(LoopMode.all)
                  : Getallsongs.audioPlayer.setLoopMode(LoopMode.one);
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
  }
}
