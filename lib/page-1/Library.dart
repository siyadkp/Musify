import 'package:flutter/material.dart';

import 'package:myapp/playlist/playlist.dart';

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SizedBox(
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
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Library',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10, top: 10),
              //       child: OutlinedButton(
              //           style: OutlinedButton.styleFrom(
              //             side: const BorderSide(
              //                 width: 0.5,
              //                 color: Color.fromARGB(255, 255, 255, 255)),
              //           ),
              //           onPressed: () {},
              //           child: const Text(
              //             'Most Played',
              //             style: TextStyle(color: Colors.white),
              //           )),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10, top: 10),
              //       child: OutlinedButton(
              //           style: OutlinedButton.styleFrom(
              //             side: const BorderSide(
              //                 width: 0.5,
              //                 color: Color.fromARGB(255, 255, 255, 255)),
              //           ),
              //           onPressed: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: ((context) =>
              //                         const Playlistwidget())));
              //           },
              //           child: const Text(
              //             'Playlist',
              //             style: TextStyle(color: Colors.white),
              //           )),
              //     )
              //   ],
              // )
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(top: 30),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Card(
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        elevation: 0,
                        color: Color.fromARGB(16, 255, 255, 255),
                        child: ListTile(
                          leading: Image.asset(
                            'assets/page-1/images/favorite.jpg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            'Mostly played',
                            style: TextStyle(
                                color: Color.fromARGB(206, 255, 255, 255),
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Card(
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        elevation: 0,
                        color: Color.fromARGB(16, 255, 255, 255),
                        child: ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const Playlistwidget()))),
                          leading: SizedBox(
                            width: 100,
                            height: 100,
                            child: SizedBox(
                              child: Image.asset(
                                'assets/page-1/images/playlist.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            'Playlist',
                            style: TextStyle(
                                color: Color.fromARGB(206, 255, 255, 255),
                                fontSize: 20),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
