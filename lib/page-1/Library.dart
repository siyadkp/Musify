import 'package:myapp/page-1/mostlyplayed.dart';
import 'package:flutter/material.dart';
import 'package:myapp/playlist/playlist.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
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
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Library',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 30),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: ListTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const MostlyScreen()))),
                        leading: Image.asset(
                          'assets/page-1/images/pexels-photo-462510.jpeg',
                          width: 80,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        title: const Text(
                          'Mostly played',
                          style: TextStyle(
                              color: Color.fromARGB(206, 255, 255, 255),
                              fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: ListTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const Playlistwidget()))),
                        leading: SizedBox(
                          width: 80,
                          height: 100,
                          child: SizedBox(
                            child: Image.asset(
                              'assets/page-1/images/pexels-photo-3756943.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: const Text(
                          'Playlist',
                          style: TextStyle(
                              color: Color.fromARGB(206, 255, 255, 255),
                              fontSize: 20),
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
