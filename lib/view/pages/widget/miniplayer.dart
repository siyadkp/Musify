import 'package:flutter/material.dart';
import 'package:myapp/controller/functions/allsong_db_functions.dart';
import 'package:myapp/controller/get_allsongs_controler.dart';
import 'package:myapp/controller/provider/play_now/player_controller_provider.dart';
import 'package:myapp/controller/provider/recently_play/recently_play.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';

import '../playnow/playnow.dart';

class MiniPlayer extends StatelessWidget {
  MiniPlayer({
    Key? key,
  }) : super(key: key);
  RecentlyPlayedNotifier recentlyPlayedNotifier = RecentlyPlayedNotifier();

  @override
  // void initState() {
  //   Getallsongs.audioPlayer.currentIndexStream.listen((index) {
  //     if (index != null && mounted) {
  //       setState(() {
  //         widget.currentIndex = index;
  //         index == 0 ? firstSong = true : firstSong = false;
  //       });
  //     }
  //   });

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    PlayerControllerNotifier _playerControllerNotifier =
        PlayerControllerNotifier();
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayNowPage(
                      songsModel: resulted,
                    )));
      },
      child: Consumer<PlayerControllerNotifier>(
          builder: (context, playerControllerNotifier, _) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.03,
                right: size.width * 0.04,
                bottom: size.width * 0.02),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white12),
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
                                  resulted[
                                          Getallsongs.audioPlayer.currentIndex!]
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
                                  resulted[
                                          Getallsongs.audioPlayer.currentIndex!]
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
                        SizedBox(
                          width: 100,
                          child: Text(
                            resulted[Getallsongs.audioPlayer.currentIndex!]
                                        .artist
                                        .toString() ==
                                    "<unknown>"
                                ? "Unknown Artist"
                                : resulted[
                                        Getallsongs.audioPlayer.currentIndex!]
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
                    firstsong
                        ? SizedBox(
                            width: size.width * 0.1,
                          )
                        : IconButton(
                            onPressed: () async {
                              recentlyPlayedNotifier.addRecentlyPlayed(resulted[
                                      Getallsongs.audioPlayer.currentIndex!]
                                  .id);
                              playerControllerNotifier.seekToPrev();
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
                        playerControllerNotifier.pauseAndplay();
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
                        recentlyPlayedNotifier.addRecentlyPlayed(
                            resulted[Getallsongs.audioPlayer.currentIndex!].id);
                        playerControllerNotifier.seekToNext();
                        // if (Getallsongs.audioPlayer.hasNext) {
                        //   await Getallsongs.audioPlayer.seekToNext();
                        //   await Getallsongs.audioPlayer.play();
                        // } else {
                        //   await Getallsongs.audioPlayer.play();
                        // }
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
        );
      }),
    );
  }

//   int currentIndex = 0;
// }

// bool firstSong = false;

// bool isPlaying = false;
}
