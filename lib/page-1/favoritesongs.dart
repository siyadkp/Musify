import 'package:flutter/material.dart';
import 'package:myapp/allmusic/allmusiclist_tile.dart';
import 'package:myapp/functions/fav_functions.dart';
import 'package:myapp/model/model.dart';

// ignore: use_key_in_widget_constructors
class LikedSongsPage extends StatefulWidget {
  @override
  State<LikedSongsPage> createState() => _LikedSongsPageState();
}

class _LikedSongsPageState extends State<LikedSongsPage> {
  @override
  void initState() {
    super.initState();
    FavoriteDB.favGet();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return ValueListenableBuilder(
      valueListenable: FavoriteDB.favoriteSongsNotifer,
      builder: (context, List<SongDbModel> favdata, child) {
        return Scaffold(
          body: SizedBox(
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
                                valueListenable:
                                    FavoriteDB.favoriteSongsNotifer,
                                builder: (context,
                                    List<SongDbModel> favoritedata,
                                    Widget? child) {
                                  if (favoritedata.isEmpty) {
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 300),
                                        child: Text(
                                          'No songs in favourites',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    final temp = favoritedata.reversed.toList();
                                    favoritedata = temp.toSet().toList();
                                    return Allmusiclisttile(
                                      songmodel: favoritedata,
                                    );
                                  }
                                }))
                      ],
                    ),
                  ))),
        );
      },
    );
  }
}
