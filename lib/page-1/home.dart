import 'package:flutter/material.dart';
import 'package:myapp/allmusic/allmusic.dart';
import 'package:myapp/controller/get_allsongs_controler.dart';
import 'package:myapp/page-1/recentlyplayed/recently_screen.dart';
import 'package:myapp/page-1/widget/miniplayer.dart';

class HomePage extends StatelessWidget {
  @override
  bool a = false;

  int bottomnavindexnum = 0;

  List<Widget> tabbarwidget = const [AllsongsWidget()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        // hometCx (1:9)
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 2,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/page-1/images/home.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, right: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Musify',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          RecentlyScreen())));
                            },
                            icon: const Icon(Icons.history_toggle_off_rounded),
                            color: Colors.white,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.settings),
                            color: Colors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 268, top: 15, bottom: 10),
                  child: Text('All Music',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500)),
                ),
                Expanded(child: tabbarwidget[bottomnavindexnum]),
                (Getallsongs.audioPlayer.currentIndex != null)
                    ? MiniPlayer()
                    : Container(),
                Container(
                  height: 55,
                  width: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
