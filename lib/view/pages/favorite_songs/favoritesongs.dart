import 'package:flutter/material.dart';
import 'package:myapp/controller/provider/fav_provider/fav_povider.dart';
import 'package:provider/provider.dart';

import '../../allmusic/allmusiclist_tile.dart';

class LikedSongsPage extends StatelessWidget {
  const LikedSongsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double screenWidth = MediaQuery.of(context).size.width;
    double scaleFactor = screenWidth / baseWidth;

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
                  padding: EdgeInsets.fromLTRB(
                    20 * scaleFactor,
                    15 * scaleFactor,
                    0,
                    10 * scaleFactor,
                  ),
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
                  child: Consumer<FavNotifier>(
                    builder: (context, favNotifier, _) {
                      if (favNotifier.favSongs.isEmpty) {
                        return const Center(
                          child: Text(
                            'No songs in favorites',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white70,
                            ),
                          ),
                        );
                      } else {
                        return Allmusiclisttile(
                          songmodel: favNotifier.favSongs,
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
  }
}
