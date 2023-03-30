import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/bottomnavigation_page/bottomnavigation_page.dart';
import 'package:myapp/controller/get_allsongs_controler.dart';
import 'package:myapp/functions/allsong_db_functions.dart';
import 'package:myapp/functions/fav_functions.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/page-1/playnow/artwork_widget.dart';
import 'package:myapp/page-1/playnow/player_controler.dart';
import '../../allmusic/allmusiclist_tile.dart';

// ignore: must_be_immutable
class PlayNowPage extends StatefulWidget {
  final List<SongDbModel> songsModel;
  final int count;

  const PlayNowPage({
    super.key,
    required this.songsModel,
    this.count = 0,
  });

  @override
  State<PlayNowPage> createState() => _PlayNowPageState();
}

class _PlayNowPageState extends State<PlayNowPage> {
  late StreamSubscription<Duration> _positionSubscription;
  Duration _duration = const Duration();
  Duration _position = const Duration();
  int large = 0;
  int currentindex = 0;
  bool firstsong = false;
  bool lastsong = false;

  @override
  void initState() {
    Getallsongs.audioPlayer.currentIndexStream.listen(
      (ind) {
        if (ind != null) {
          Getallsongs.currentindexgetallsongs = ind;
          if (mounted) {
            setState(() {
              large = widget.count - 1;
              currentindex = ind;
              ind == 0 ? firstsong == true : firstsong == false;
              ind == large ? lastsong = true : lastsong = false;
            });
          }
        }
      },
    );
    super.initState();
    playsongs();
  }

  playsongs() {
    Getallsongs.audioPlayer.play();
    Getallsongs.audioPlayer.durationStream.listen((D) {
      _duration = D!;
    });

    _positionSubscription = Getallsongs.audioPlayer.positionStream.listen((P) {
      setState(() {
        _position = P;
      });
    });
  }

  void changeToSeconds(int secondas) {
    Duration duration = Duration(seconds: secondas);
    Getallsongs.audioPlayer.seek(duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .609,
              width: 500,
              color: Colors.deepPurple[200],
              child: Align(
                alignment: Alignment.topLeft,
                child: Stack(
                  children: [
                    ArtworkWidget(widget: widget, currentindex: currentindex),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BottomNavigationPage()),
                                (Route route) => false);
                          },
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          color: Colors.white,
                        ),
                        PopupMenuButton(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          icon: const Icon(
                            Icons.more_vert,
                            size: 20,
                          ),
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 1,
                              child: Text(
                                'Add playlist',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Text(
                                FavoriteDB.favSongChecking(
                                        widget.songsModel[currentindex])
                                    ? 'Remove Favorites'
                                    : 'Add Favorites',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 39, 33, 55),
                                ),
                              ),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 1) {
                              showPlaylistdialog(
                                  context, resulted[currentindex]);
                            } else if (value == 2) {
                              bool condition = FavoriteDB.favSongChecking(
                                  widget.songsModel[currentindex]);
                              if (condition == true) {
                                FavoriteDB.favDelete(
                                    widget.songsModel[currentindex].id);
                                const remove = SnackBar(
                                  backgroundColor:
                                      Color.fromARGB(222, 38, 46, 67),
                                  content: Center(
                                    child: Text(
                                      'Song Removed In Favorate List',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white70),
                                    ),
                                  ),
                                  duration: Duration(seconds: 2),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(remove);
                              } else {
                                FavoriteDB.favAdd(
                                    widget.songsModel[currentindex].id,
                                    widget.songsModel[currentindex]);
                                const add = SnackBar(
                                  backgroundColor:
                                      Color.fromARGB(222, 38, 46, 67),
                                  content: Center(
                                      child: Center(
                                    child: Text(
                                      'Song Added In Favorate List',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white70),
                                    ),
                                  )),
                                  duration: Duration(seconds: 2),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(add);
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .3509,
              color: Colors.deepPurple[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: 300,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 50),
                                      child: SizedBox(
                                        width: 245,
                                        child: Text(
                                          widget.songsModel[currentindex]
                                              .displayNameWOExt,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 290,
                                      child: Text(
                                        widget.songsModel[currentindex].artist
                                                    .toString() ==
                                                "unknown"
                                            ? "Unknown Artist"
                                            : widget
                                                .songsModel[currentindex].artist
                                                .toString(),
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 82, 79, 79),
                                            fontSize: 15),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (FavoriteDB.favSongChecking(
                                      widget.songsModel[currentindex])) {
                                    FavoriteDB.favDelete(
                                        widget.songsModel[currentindex].id);

                                    const remove = SnackBar(
                                      duration: Duration(seconds: 2),
                                      backgroundColor:
                                          Color.fromARGB(222, 38, 46, 67),
                                      content: Center(
                                        child: Text(
                                          'Song Removed In Favorate List',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white70),
                                        ),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(remove);
                                  } else {
                                    FavoriteDB.favAdd(
                                        widget.songsModel[currentindex].id,
                                        widget.songsModel[currentindex]);
                                    const add = SnackBar(
                                      duration: Duration(seconds: 2),
                                      backgroundColor:
                                          Color.fromARGB(222, 38, 46, 67),
                                      content: Center(
                                        child: Text(
                                          'Song Added In Favorate List',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white70),
                                        ),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(add);
                                  }
                                });
                              },
                              icon: FavoriteDB.favSongChecking(
                                      widget.songsModel[currentindex])
                                  ? const Icon(
                                      Icons.favorite_sharp,
                                      color: Colors.red,
                                      size: 30,
                                    )
                                  : const Icon(
                                      Icons.favorite_border_sharp,
                                      color: Colors.white,
                                      size: 30,
                                    ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 10),
                            child: Slider(
                                thumbColor: Colors.white,
                                activeColor: Colors.white70,
                                inactiveColor: Colors.grey,
                                min: const Duration(microseconds: 0)
                                    .inSeconds
                                    .toDouble(),
                                value: _position.inSeconds.toDouble(),
                                max: _duration.inSeconds.toDouble(),
                                onChanged: (value) {
                                  setState(() {
                                    changeToSeconds(value.toInt());
                                    value = value;
                                  });
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _position.toString().split(".")[0],
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  _duration.toString().split(".")[0],
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          Playercontroler(
                              count: widget.count,
                              firstsong: firstsong,
                              lastsong: lastsong,
                              songModel: widget.songsModel[currentindex])
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _positionSubscription.cancel();
  }
}
