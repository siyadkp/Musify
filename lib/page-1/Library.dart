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
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/page-1/images/playlist.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10 * fem, vertical: 10 * fem),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Library',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                33, // adjust font size based on device width
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        vertical: 30, horizontal: 10 * fem),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 20 * fem),
                        child: ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const MostlyScreen()))),
                          leading: Image.asset(
                            'assets/page-1/images/pexels-photo-462510.jpeg',
                            width:
                                92, // adjust image width based on device width
                            height:
                                100, // adjust image height based on device width
                            fit: BoxFit.cover,
                          ),
                          title: const Text(
                            'Mostly played',
                            style: TextStyle(
                                color: Color.fromARGB(206, 255, 255, 255),
                                fontSize:
                                    21, // adjust font size based on device width
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20 * fem),
                        child: ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const Playlistwidget()))),
                          leading: SizedBox(
                            width:
                                92, // adjust image width based on device width
                            height: 100 *
                                fem, // adjust image height based on device width
                            child: Image.asset(
                              'assets/page-1/images/pexels-photo-3756943.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: const Text(
                            'Playlist',
                            style: TextStyle(
                                color: Color.fromARGB(206, 255, 255, 255),
                                fontSize:
                                    21, // adjust font size based on device width
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
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
