import 'package:flutter/material.dart';
import 'package:myapp/controller/get_allsongs_controler.dart';
import 'package:myapp/functions/fav_functions.dart';
import 'package:myapp/page-1/playnow/artwork_widget.dart';
import 'package:myapp/page-1/playnow/player_controler.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class PlayNowPage extends StatefulWidget {
  final List<SongModel> songsModel;
  int count = 0;

  PlayNowPage({
    super.key,
    required this.songsModel,
    required this.count,
  });

  @override
  State<PlayNowPage> createState() => _PlayNowPageState();
}

class _PlayNowPageState extends State<PlayNowPage> {
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
      setState(() {
        _duration = D!;
      });
    });
    Getallsongs.audioPlayer.positionStream.listen((P) {
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 500,
              width: 500,
              color: Colors.deepPurple[200],
              child: Align(
                alignment: Alignment.topLeft,
                child: Stack(
                  children: [
                    Container(
                        child: ArtworkWidget(
                            widget: widget, currentindex: currentindex)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert_outlined),
                          color: Colors.white,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 288,
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
                                      child: Container(
                                        width: 245,
                                        child: Text(
                                          widget.songsModel[currentindex]
                                              .displayNameWOExt,
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
                                  if (FavoriteDB.isFavor(
                                      widget.songsModel[currentindex])) {
                                    FavoriteDB.delete(
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
                                    FavoriteDB.add(
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

                                FavoriteDB.favoriteSongs.notifyListeners();
                              },
                              icon: FavoriteDB.isFavor(
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
}
