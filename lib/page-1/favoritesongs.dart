import 'package:flutter/material.dart';
import 'package:myapp/allmusic/allmusiclist_tile.dart';
import 'package:myapp/functions/fav_functions.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: use_key_in_widget_constructors
class LikedSongsPage extends StatefulWidget {
  @override
  State<LikedSongsPage> createState() => _LikedSongsPageState();
}

class _LikedSongsPageState extends State<LikedSongsPage> {
  @override
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return ValueListenableBuilder(
      valueListenable: FavoriteDB.favoriteSongs,
      builder: (context, List<SongModel> favdata, child) {
        return Scaffold(
          body: Container(
              // likedsongs9Ut (2:49)
              width: double.infinity,
              height: 800 * fem,
              child: DecoratedBox(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/page-1/images/likedsongs.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 20, top: 15, bottom: 10),
                          child: Text('Favorite Songs',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500)),
                        ),
                        SizedBox(
                          child: ValueListenableBuilder(
                            valueListenable: FavoriteDB.favoriteSongs,
                            builder: (context, List<SongModel> value, child) {
                              if (value.isEmpty) {
                                const Center(
                                  child: Text('No songs'),
                                );
                              } else {
                                final tempdata = value.reversed.toList();
                                value = tempdata.toSet().toList();
                              }
                              return Allmusiclisttile(songmodel: value);
                            },
                          ),
                        )
                      ],
                    ),
                  ))),
        );
      },
    );
  }
}
