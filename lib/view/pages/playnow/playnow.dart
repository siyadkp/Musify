// ignore: must_be_immutable
import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/controller/provider/fav_provider/fav_povider.dart';
import 'package:myapp/controller/provider/play_now/player_controller_provider.dart';
import 'package:provider/provider.dart';

import '../../../controller/functions/allsong_db_functions.dart';
import '../../../controller/get_allsongs_controler.dart';
import '../../../model/model.dart';
import '../../allmusic/allmusiclist_tile.dart';
import '../../bottomnavigation_page/bottomnavigation_page.dart';
import 'artwork_widget.dart';
import 'player_controler.dart';
import 'widget/slider.dart';

int large = 0;
int currentindex = 0;
bool firstsong = false;
bool lastsong = false;
bool isplaying = true;
bool isrepeat = false;
bool isshuffle = false;

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
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.6), // backgroundC
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/page-1/images/likedsongs.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: SafeArea(
                child: Consumer<PlayerControllerNotifier>(
                    builder: (context, playerControllerNotifier, child) {
                  return ListView(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: ArtworkWidget(
                                widget: widget, currentindex: currentindex),
                          ),
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
                                icon:
                                    const Icon(Icons.keyboard_arrow_down_sharp),
                                color: Colors.white,
                              ),
                              Consumer<FavNotifier>(
                                  builder: (context, favNotifier, child) {
                                return PopupMenuButton(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
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
                                        favNotifier.favChecking(
                                                widget.songsModel[currentindex])
                                            ? 'Remove Favorites'
                                            : 'Add Favorites',
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 39, 33, 55),
                                        ),
                                      ),
                                    ),
                                  ],
                                  onSelected: (value) {
                                    if (value == 1) {
                                      showPlaylistdialog(
                                          context, resulted[currentindex]);
                                    } else if (value == 2) {
                                      favNotifier.favAction(
                                          resulted[currentindex], context);
                                    }
                                  },
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 110 * fem),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .3509,
                          child: Padding(
                            padding: EdgeInsets.all(8 * fem),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 30 * fem,
                                      left: 15 * fem,
                                      right: 15 * fem),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 260 * fem,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 50 * fem),
                                                  child: SizedBox(
                                                    width: 230 * fem,
                                                    child: Text(
                                                      widget
                                                          .songsModel[
                                                              currentindex]
                                                          .displayNameWOExt,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 290 * fem,
                                                  child: Text(
                                                    widget
                                                                .songsModel[
                                                                    currentindex]
                                                                .artist
                                                                .toString() ==
                                                            "unknown"
                                                        ? "Unknown Artist"
                                                        : widget
                                                            .songsModel[
                                                                currentindex]
                                                            .artist
                                                            .toString(),
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 82, 79, 79),
                                                        fontSize: 15),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Consumer<FavNotifier>(
                                          builder: (context, favNotifier, _) {
                                        return IconButton(
                                            onPressed: () {
                                              favNotifier.favAction(
                                                  resulted[currentindex],
                                                  context);
                                            },
                                            icon: favNotifier.favChecking(
                                                    resulted[currentindex])
                                                ? const Icon(
                                                    Icons.favorite_sharp,
                                                    color: Colors.red,
                                                    size: 30,
                                                  )
                                                : const Icon(
                                                    Icons.favorite_border_sharp,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ));
                                      })
                                    ],
                                  ),
                                ),
                                SongDurationsController(
                                  position: _position,
                                  duration: _duration,
                                ),
                                Expanded(
                                  child: Playercontroler(
                                      count: widget.count,
                                      lastsong: lastsong,
                                      songModel: widget.songsModel),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }),
              ),
            )));
  }

  @override
  void dispose() {
    super.dispose();
    _positionSubscription.cancel();
  }
}






















// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:myapp/controller/get_allsongs_controler.dart';
// import 'package:myapp/model/model.dart';
// import 'package:myapp/view/pages/playnow/widget/slider.dart';
// import 'package:provider/provider.dart';
// import '../../../controller/functions/allsong_db_functions.dart';
// import '../../../controller/provider/fav_provider/fav_povider.dart';
// import '../../../controller/provider/play_now/play_now.dart';
// import '../../../controller/provider/play_now/player_controller_provider.dart';
// import '../../allmusic/allmusiclist_tile.dart';
// import '../../bottomnavigation_page/bottomnavigation_page.dart';
// import 'artwork_widget.dart';
// import 'player_controler.dart';

// // ignore: must_be_immutable
// class PlayNowPage extends StatelessWidget {
//   final List<SongDbModel> songsModel;
//   final int count;
//   final int currentIndex;
//   PlayNowPage({
//     super.key,
//     required this.songsModel,
//     required this.currentIndex,
//     this.count = 0,
//   });

//   // int currentindex = 0;
//   // late StreamSubscription<Duration> _positionSubscription;
//   // Duration _duration = const Duration();
//   // Duration _position = const Duration();
//   // int large = 0;
//   // bool firstsong = false;
//   // bool lastsong = false;

//   @override
//   // void initState() {
//   //   Getallsongs.audioPlayer.currentIndexStream.listen(
//   //     (ind) {
//   //       if (ind != null) {
//   //         Getallsongs.currentindexgetallsongs = ind;
//   //         if (mounted) {
//   //           setState(() {
//   //             large = widget.count - 1;
//   //             currentindex = ind;
//   //             currentindex == 0 ? firstsong == true : firstsong == false;
//   //             currentindex == large ? lastsong = true : lastsong = false;
//   //           });
//   //         }
//   //       }
//   //     },
//   //   );
//   //   super.initState();
//   //   playsongs();
//   // }

//   // playsongs() {
//   //   Getallsongs.audioPlayer.play();
//   //   Getallsongs.audioPlayer.durationStream.listen((D) {
//   //     _duration = D!;
//   //   });

//   //   _positionSubscription = Getallsongs.audioPlayer.positionStream.listen((P) {
//   //     setState(() {
//   //       _position = P;
//   //     });
//   //   });
//   // }

//   // void changeToSeconds(int secondas) {
//   //   Duration duration = Duration(seconds: secondas);
//   //   Getallsongs.audioPlayer.seek(duration);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // PlayNowNotifier _playNowNotifier = PlayNowNotifier(count, currentIndex);
//     PlayerControllerNotifier _playerControllerNotifier =
//         PlayerControllerNotifier(count, currentIndex);
//     double baseWidth = 360;
//     double fem = MediaQuery.of(context).size.width / baseWidth;
//     return Scaffold(
//         backgroundColor: Colors.white.withOpacity(0.6), // backgroundC
//         body: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/page-1/images/likedsongs.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//             child: SafeArea(
//               child: Consumer<PlayerControllerNotifier>(
//                   builder: (context, playerControllerNotifier, child) {
//                 print('hi');
//                 return ListView(
//                   children: [
//                     Stack(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 100),
//                           child: ArtworkWidget(
//                               currentindex:
//                                   playerControllerNotifier.currentindex),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             IconButton(
//                               onPressed: () {
//                                 Navigator.of(context).pushAndRemoveUntil(
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             const BottomNavigationPage()),
//                                     (Route route) => false);
//                               },
//                               icon: const Icon(Icons.keyboard_arrow_down_sharp),
//                               color: Colors.white,
//                             ),
//                             Consumer<FavNotifier>(
//                                 builder: (context, favNotifier, child) {
//                               return PopupMenuButton(
//                                 color: const Color.fromARGB(255, 255, 255, 255),
//                                 icon: const Icon(
//                                   Icons.more_vert,
//                                   size: 20,
//                                 ),
//                                 itemBuilder: (context) => [
//                                   const PopupMenuItem(
//                                     value: 1,
//                                     child: Text(
//                                       'Add playlist',
//                                       style: TextStyle(
//                                         color: Color.fromARGB(255, 0, 0, 0),
//                                       ),
//                                     ),
//                                   ),
//                                   PopupMenuItem(
//                                     value: 2,
//                                     child: Text(
//                                       favNotifier.favChecking(songsModel[
//                                               playerControllerNotifier
//                                                   .currentindex])
//                                           ? 'Remove Favorites'
//                                           : 'Add Favorites',
//                                       style: const TextStyle(
//                                         color: Color.fromARGB(255, 39, 33, 55),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                                 onSelected: (value) {
//                                   if (value == 1) {
//                                     showPlaylistdialog(
//                                         context,
//                                         resulted[playerControllerNotifier
//                                             .currentindex]);
//                                   } else if (value == 2) {
//                                     favNotifier.favAction(
//                                         resulted[playerControllerNotifier
//                                             .currentindex],
//                                         context);
//                                   }
//                                 },
//                               );
//                             }),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(top: 110 * fem),
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height * .3509,
//                         child: Padding(
//                           padding: EdgeInsets.all(8 * fem),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     top: 30 * fem,
//                                     left: 15 * fem,
//                                     right: 15 * fem),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       children: [
//                                         SizedBox(
//                                           width: 260 * fem,
//                                           child: Column(
//                                             children: [
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                     right: 50 * fem),
//                                                 child: SizedBox(
//                                                   width: 230 * fem,
//                                                   child: Text(
//                                                     resulted[
//                                                             playerControllerNotifier
//                                                                 .currentindex]
//                                                         .displayNameWOExt,
//                                                     maxLines: 1,
//                                                     style: const TextStyle(
//                                                         color: Colors.white,
//                                                         fontSize: 20),
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 290 * fem,
//                                                 child: Text(
//                                                   resulted[playerControllerNotifier
//                                                                   .currentindex]
//                                                               .artist
//                                                               .toString() ==
//                                                           "unknown"
//                                                       ? "Unknown Artist"
//                                                       : resulted[
//                                                               playerControllerNotifier
//                                                                   .currentindex]
//                                                           .artist
//                                                           .toString(),
//                                                   overflow: TextOverflow.fade,
//                                                   maxLines: 1,
//                                                   softWrap: false,
//                                                   style: const TextStyle(
//                                                       color: Color.fromARGB(
//                                                           255, 82, 79, 79),
//                                                       fontSize: 15),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Consumer<FavNotifier>(
//                                         builder: (context, favNotifier, _) {
//                                       return IconButton(
//                                           onPressed: () {
//                                             favNotifier.favAction(
//                                                 resulted[
//                                                     playerControllerNotifier
//                                                         .currentindex],
//                                                 context);
//                                           },
//                                           icon: favNotifier.favChecking(
//                                                   resulted[
//                                                       playerControllerNotifier
//                                                           .currentindex])
//                                               ? const Icon(
//                                                   Icons.favorite_sharp,
//                                                   color: Colors.red,
//                                                   size: 30,
//                                                 )
//                                               : const Icon(
//                                                   Icons.favorite_border_sharp,
//                                                   color: Colors.white,
//                                                   size: 30,
//                                                 ));
//                                     })
//                                   ],
//                                 ),
//                               ),
//                               SongDurationsController(
//                                 position: position,
//                                 duration: duration,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 );
//               }),
//             ),
//           ),
//         ));
//   }

//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   _positionSubscription.cancel();
//   // }
// }
