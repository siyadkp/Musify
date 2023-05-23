import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myapp/controller/provider/playlist_provider/playlist_provider.dart';
import 'package:provider/provider.dart';
import '../../../../controller/provider/playlist_provider/playlist_all_songs.dart';
import 'playlistindividual.dart';

final GlobalKey<FormState> formkey = GlobalKey<FormState>();

class Playlistwidget extends StatelessWidget {
  const Playlistwidget({super.key});
  @override
  Widget build(BuildContext context) {
    final playlistAllSongsDisplayNotifier =
        Provider.of<PlaylistAllSongsDisplayNotifier>(context, listen: false);
    final playlistNotifier =
        Provider.of<PlaylistNotifier>(context, listen: false);
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/page-1/images/home.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white38,
                      )),
                  const Text(
                    'Playlist',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.width *
                            0.55 // Portrait width
                        : MediaQuery.of(context).size.width *
                            0.75, // Landscape width
                  ),
                  IconButton(
                    onPressed: () {
                      playlistNotifier.newplaylist(context, formkey);
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white38,
                      size: 40,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.03,
                      right: MediaQuery.of(context).size.width * 0.03),
                  child: SizedBox(
                    width: double.infinity,
                    child: Consumer<PlaylistNotifier>(
                      builder: (BuildContext context, playlistNotifier, _) {
                        if (playlistNotifier.playliatDatas.isEmpty) {
                          return const Center(
                            child: Text(
                              'Add playlist',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 25),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: playlistNotifier.playliatDatas.length,
                            itemBuilder: (context, index) {
                              return Slidable(
                                endActionPane: ActionPane(
                                  motion: const BehindMotion(),
                                  children: [
                                    SlidableAction(
                                      spacing: 0,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      onPressed: (context) {
                                        playlistNotifier.deletePlaylist(
                                            context, index);
                                      },
                                      icon: Icons.delete_outline,
                                      foregroundColor: Colors.red,
                                      backgroundColor: Colors.transparent,
                                    ),
                                    SlidableAction(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      onPressed: (context) {
                                        playlistNotifier.editPlaylistName(
                                            context,
                                            playlistNotifier
                                                .playliatDatas[index],
                                            index);
                                      },
                                      icon: Icons.edit,
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.02),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.matrix([
                                            0.5, 0, 0, 0, 0, // red
                                            0, 0.5, 0, 0, 0, // green
                                            0, 0, 0.5, 0, 0, // blue
                                            0, 0, 0, 1, 0, // alpha
                                          ]),
                                          image: AssetImage(
                                            'assets/page-1/images/pexels-photo-3756766.jpeg',
                                          ),
                                        ),
                                        color: const Color.fromARGB(
                                            255, 29, 29, 45),
                                        borderRadius: BorderRadius.circular(15),
                                        border:
                                            Border.all(color: Colors.white30)),
                                    child: ListTile(
                                      onTap: () {
                                        playlistAllSongsDisplayNotifier
                                            .playlistSongFetching(
                                                playlistNotifier
                                                    .playliatDatas[index]);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Playlisttoaddsong(
                                              playlistIndex: index,
                                              playlistName: playlistNotifier
                                                  .playliatDatas[index],
                                            ),
                                          ),
                                        );
                                      },
                                      leading: const Icon(
                                        Icons.music_note_outlined,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      title: Text(
                                        playlistNotifier.playliatDatas[index],
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      ),
                                      trailing: const Icon(
                                        Icons.compare_arrows,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
