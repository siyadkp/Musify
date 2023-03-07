import 'package:flutter/material.dart';

import 'package:myapp/playlist/playlist.dart';

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      // playlist4VN (2:68)
      width: double.infinity,
      height: 800 * fem,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/page-1/images/playlist.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(children: [
            const Text(
              'Library',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            width: 0.5,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Most Played',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            width: 0.5,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const Playlistwidget())));
                      },
                      child: const Text(
                        'Playlist',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
