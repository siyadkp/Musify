import 'package:flutter/material.dart';
import 'package:myapp/allmusic/allmusiclist_tile.dart';
import 'package:myapp/functions/fav_functions.dart';
import 'package:myapp/model/model.dart';

class LikedSongsPage extends StatefulWidget {
  const LikedSongsPage({super.key});

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
    double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = screenWidth / baseWidth;
    return ValueListenableBuilder(
      valueListenable: FavoriteDB.favoriteSongsNotifer,
      builder: (context, List<SongDbModel> favdata, child) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(20 * scaleFactor,
                          15 * scaleFactor, 0, 10 * scaleFactor),
                      child: const Text(
                        'Favorite Songs',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: FavoriteDB.favoriteSongsNotifer,
                        builder: (context, List<SongDbModel> favoritedata,
                            Widget? child) {
                          if (favoritedata.isEmpty) {
                            return const Center(
                              child: Text(
                                'No songs in favourites',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white70,
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
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
