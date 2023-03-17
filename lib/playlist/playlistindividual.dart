import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myapp/controller/get_allsongs_controler.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/page-1/playnow/playnow.dart';
import 'package:myapp/playlist/playlistsongdisplyscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Playlisttoaddsong extends StatefulWidget {
  const Playlisttoaddsong(
      {super.key, required this.sindex, required this.playlist});
  final int sindex;
  final Playermodel playlist;

  @override
  State<Playlisttoaddsong> createState() => _PlaylisttoaddsongState();
}

class _PlaylisttoaddsongState extends State<Playlisttoaddsong> {
  @override
  Widget build(BuildContext context) {
    late List<SongModel> songplaylist;
    return Scaffold(
      backgroundColor: Colors.deepPurple[900],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white60,
            )),
        title: Text(
          widget.playlist.name,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(12),
            child: ValueListenableBuilder(
              valueListenable: Hive.box<Playermodel>('playlistDb').listenable(),
              builder: (context, Box<Playermodel> song, Widget? child) {
                songplaylist =
                    listplaylist(song.values.toList()[widget.sindex].songid);
                return songplaylist.isEmpty
                    ? const Center(
                        child: Text(
                          'Add Songs',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white60),
                        ),
                      )
                    : ListView.builder(
                        itemCount: songplaylist.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: QueryArtworkWidget(
                              type: ArtworkType.AUDIO,
                              id: songplaylist[index].id,
                              artworkHeight: 60,
                              artworkWidth: 60,
                              nullArtworkWidget: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: const Icon(
                                    Icons.music_note,
                                    color: Colors.white60,
                                  )),
                              artworkBorder: BorderRadius.circular(10),
                              artworkFit: BoxFit.cover,
                            ),
                            title: Text(songplaylist[index].title,
                                maxLines: 1,
                                style: const TextStyle(color: Colors.white70)),
                            subtitle: Text(
                              songplaylist[index].artist!,
                              style: const TextStyle(color: Colors.white70),
                              maxLines: 1,
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  widget.playlist
                                      .deletedata(songplaylist[index].id);
                                  const removesongplaylistsnake = SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(222, 38, 46, 67),
                                      duration: Duration(seconds: 1),
                                      content: Center(
                                          child: Text(
                                              'Music Removed In Playlist')));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(removesongplaylistsnake);
                                },
                                icon: const Icon(Icons.delete_outline,
                                    color: Color.fromARGB(255, 224, 86, 76))),
                            onTap: () {
                              Getallsongs.audioPlayer.setAudioSource(
                                  Getallsongs.createsongslist(songplaylist),
                                  initialIndex: index);
                              // context
                              //     .read<Songmodelprovider>()
                              //     .setid(widget.songmodel[index].id);

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PlayNowPage(
                                      songsModel: songplaylist,
                                      count: songplaylist.length)));
                            },
                          ),
                        ),
                      );
              },
            ),
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple[400],
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Playlistsongdisplayscreen(
                        playlist: widget.playlist,
                      )));
        },
        label: const Text('Add Songs'),
      ),
    );
  }

  List<SongModel> listplaylist(List<int> data) {
    List<SongModel> playsong = [];
    for (int i = 0; i < Getallsongs.copysong.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (Getallsongs.copysong[i].id == data[j]) {
          playsong.add(Getallsongs.copysong[i]);
        }
      }
    }

    return playsong;
  }
}
