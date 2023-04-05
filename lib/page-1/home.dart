import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/allmusic/allmusic.dart';
import 'package:myapp/controller/get_allsongs_controler.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/page-1/recentlyplayed/recently_screen.dart';
import 'package:myapp/page-1/settings/settings_screen.dart';
import 'package:myapp/page-1/widget/miniplayer.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
  bool a = false;
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final allsongDb = Hive.box<SongDbModel>('songs');
    allsongDb.clear();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Scaffold(
      body: SizedBox(
        // hometCx (1:9)
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
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
                  padding:
                      EdgeInsets.fromLTRB(15 * fem, 15 * fem, 3 * fem, 0 * fem),
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
                                          const RecentlyScreen())));
                            },
                            icon: const Icon(Icons.history_toggle_off_rounded),
                            color: Colors.white,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const SettingsScreen())));
                            },
                            icon: const Icon(Icons.settings),
                            color: Colors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16 * fem, top: 10 * fem),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'All Music',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: AllsongsWidget()),
                (Getallsongs.audioPlayer.currentIndex != null)
                    ? const MiniPlayer()
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
