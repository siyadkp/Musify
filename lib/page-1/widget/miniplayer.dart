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
          padding: EdgeInsets.only(
              left: size.width * 0.03,
              right: size.width * 0.04,
              bottom: size.width * 0.02),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white12),
            height: 60,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<bool>(
                        stream: Getallsongs.audioPlayer.playingStream,
                        builder: (context, snapshot) {
                          bool? playingStage = snapshot.data;
                          if (playingStage != null && playingStage) {
                            return SizedBox(
                              width: 200,
                              child: TextScroll(
                                resulted[Getallsongs.audioPlayer.currentIndex!]
                                    .displayNameWOExt,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.04),
                              ),
                            );
                          } else {
                            return SizedBox(
                              width: 200,
                              child: Text(
                                resulted[Getallsongs.audioPlayer.currentIndex!]
                                    .displayNameWOExt,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.white,
                                    fontSize: 17),
                              ),
                            );
                          }
                        },
                      ),
                      Container(
                        width: 100,
                        child: Text(
                          resulted[Getallsongs.audioPlayer.currentIndex!]
                                      .artist
                                      .toString() ==
                                  "<unknown>"
                              ? "Unknown Artist"
                              : resulted[Getallsongs.audioPlayer.currentIndex!]
                                  .artist
                                  .toString(),
                          style: const TextStyle(
                              fontSize: 9,
                              color: Color.fromARGB(255, 172, 184, 190)),
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                  firstSong
                      ? SizedBox(
                          width: size.width * 0.1,
                        )
                      : IconButton(
                          onPressed: () async {
                            GetRecentlyPlayed.addRecentlyPlayed(
                                resulted[Getallsongs.audioPlayer.currentIndex!]
                                    .id);
                            if (Getallsongs.audioPlayer.hasPrevious) {
                              await Getallsongs.audioPlayer.seekToPrevious();
                              await Getallsongs.audioPlayer.play();
                            } else {
                              await Getallsongs.audioPlayer.play();
                            }
                          },
                          icon: const Icon(Icons.skip_previous),
                          color: Colors.white,
                          iconSize: 30,
                        ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: const CircleBorder(),
                    ),
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
                    onPressed: () async {
                      GetRecentlyPlayed.addRecentlyPlayed(
                          resulted[Getallsongs.audioPlayer.currentIndex!].id);
                      if (Getallsongs.audioPlayer.hasNext) {
                        await Getallsongs.audioPlayer.seekToNext();
                        await Getallsongs.audioPlayer.play();
                      } else {
                        await Getallsongs.audioPlayer.play();
                      }
                    },
                    icon: const Icon(
                      Icons.skip_next,
                      size: 30,
                    ),
                    color: Colors.white,
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
