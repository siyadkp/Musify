import 'package:flutter/material.dart';
import 'package:myapp/controller/get_allsongs_controler.dart';
import 'package:myapp/functions/allsong_db_functions.dart';
import 'package:myapp/functions/recpaly_functions.dart';
import 'package:myapp/page-1/playnow/playnow.dart';
import 'package:text_scroll/text_scroll.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({
    Key? key,
  }) : super(key: key);
  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

bool firstSong = false;

bool isPlaying = false;

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  void initState() {
    Getallsongs.audioPlayer.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {
          index == 0 ? firstSong = true : firstSong = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayNowPage(songsModel: resulted)));
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple[400]),
            height: 60,
            child: Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    width: size.width * 0.95,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: size.width * 0.5,
                            margin: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StreamBuilder<bool>(
                                  stream: Getallsongs.audioPlayer.playingStream,
                                  builder: (context, snapshot) {
                                    bool? playingStage = snapshot.data;
                                    if (playingStage != null && playingStage) {
                                      return TextScroll(
                                        resulted[Getallsongs
                                                .audioPlayer.currentIndex!]
                                            .displayNameWOExt,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      );
                                    } else {
                                      return Text(
                                        resulted[Getallsongs
                                                .audioPlayer.currentIndex!]
                                            .displayNameWOExt,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.white,
                                            fontSize: 14),
                                      );
                                    }
                                  },
                                ),
                                TextScroll(
                                  resulted[Getallsongs
                                                  .audioPlayer.currentIndex!]
                                              .artist
                                              .toString() ==
                                          "<unknown>"
                                      ? "Unknown Artist"
                                      : resulted[Getallsongs
                                              .audioPlayer.currentIndex!]
                                          .artist
                                          .toString(),
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color:
                                          Color.fromARGB(255, 172, 184, 190)),
                                  mode: TextScrollMode.endless,
                                ),
                              ],
                            ),
                          ),
                          firstSong
                              ? const SizedBox(
                                  width: 45,
                                )
                              : IconButton(
                                  iconSize: 32,
                                  onPressed: () async {
                                    GetRecentlyPlayed.addRecentlyPlayed(
                                        resulted[Getallsongs
                                                .audioPlayer.currentIndex!]
                                            .id);
                                    if (Getallsongs.audioPlayer.hasPrevious) {
                                      await Getallsongs.audioPlayer
                                          .seekToPrevious();
                                      await Getallsongs.audioPlayer.play();
                                    } else {
                                      await Getallsongs.audioPlayer.play();
                                    }
                                  },
                                  icon: const Icon(Icons.skip_previous),
                                  color: Colors.white,
                                ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shape: const CircleBorder()),
                            onPressed: () async {
                              setState(() {
                                isPlaying = !isPlaying;
                              });
                              if (Getallsongs.audioPlayer.playing) {
                                await Getallsongs.audioPlayer.pause();
                                setState(() {});
                              } else {
                                await Getallsongs.audioPlayer.play();
                                setState(() {});
                              }
                            },
                            child: StreamBuilder<bool>(
                              stream: Getallsongs.audioPlayer.playingStream,
                              builder: (context, snapshot) {
                                bool? playingStage = snapshot.data;
                                if (playingStage != null && playingStage) {
                                  return const Icon(
                                    Icons.pause_circle,
                                    color: Color.fromARGB(255, 219, 219, 219),
                                    size: 35,
                                  );
                                } else {
                                  return const Icon(
                                    Icons.play_circle,
                                    color: Color.fromARGB(255, 219, 219, 219),
                                    size: 35,
                                  );
                                }
                              },
                            ),
                          ),
                          IconButton(
                            iconSize: 35,
                            onPressed: () async {
                              GetRecentlyPlayed.addRecentlyPlayed(resulted[
                                      Getallsongs.audioPlayer.currentIndex!]
                                  .id);

                              if (Getallsongs.audioPlayer.hasNext) {
                                await Getallsongs.audioPlayer.seekToNext();
                                await Getallsongs.audioPlayer.play();
                              } else {
                                await Getallsongs.audioPlayer.play();
                              }
                            },
                            icon: const Icon(
                              Icons.skip_next,
                              size: 32,
                            ),
                            color: Colors.white,
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
