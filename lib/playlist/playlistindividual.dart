import 'package:flutter/material.dart';
import 'package:myapp/controller/get_allsongs_controler.dart';
import 'package:myapp/functions/playlist/song_add_to_playlist.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/page-1/playnow/playnow.dart';
import 'package:myapp/playlist/playlistsongdisplyscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Playlisttoaddsong extends StatefulWidget {
  const Playlisttoaddsong(
      {super.key, required this.playlistIndex, required this.playlistName});
  final int playlistIndex;
  final String playlistName;

  @override
  State<Playlisttoaddsong> createState() => _PlaylisttoaddsongState();
}

class _PlaylisttoaddsongState extends State<Playlisttoaddsong> {
  @override
  void initState() {
    super.initState();
    PlaylistSongDB.playlistSongGet(widget.playlistName);
  }

  @override
  Widget build(BuildContext context) {
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
          widget.playlistName,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ValueListenableBuilder(
                  valueListenable: PlaylistSongDB.playlistSongsNotifer,
                  builder: (context, song, Widget? child) {
                    return song.isEmpty
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
                            itemCount: song.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: QueryArtworkWidget(
                                  type: ArtworkType.AUDIO,
                                  id: song[index].song.id,
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
                                title: Text(song[index].song.displayName,
                                    maxLines: 1,
                                    style:
                                        const TextStyle(color: Colors.white70)),
                                subtitle: Text(
                                  song[index].song.artist,
                                  style: const TextStyle(color: Colors.white70),
                                  maxLines: 1,
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      PlaylistSongDB.playlisSongDelete(
                                          widget.playlistName,
                                          song[index].index);
                                    },
                                    icon: const Icon(Icons.delete_outline,
                                        color:
                                            Color.fromARGB(255, 224, 86, 76))),
                                onTap: () {
                                  Getallsongs.audioPlayer.setAudioSource(
                                      Getallsongs.createsongslist(
                                          playlistResult),
                                      initialIndex: index);
                                  // context
                                  //     .read<Songmodelprovider>()
                                  //     .setid(widget.songmodel[index].id);

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PlayNowPage(
                                          songsModel: playlistResult,
                                          count: song.length)));
                                },
                              ),
                            ),
                          );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple[400],
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Playlistsongdisplayscreen(
                        playlistIndex: widget.playlistIndex,
                        playlistName: widget.playlistName,
                      )));
        },
        label: const Text('Add Songs'),
      ),
    );
  }

  List<SongDbModel> listplaylist(List<int> data) {
    List<SongDbModel> playsong = [];
    for (int i = 0; i < Getallsongs.copysong.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (Getallsongs.copysong[i].id == data[j]) {
          playsong.add(Getallsongs.copysong[i]);
        }
      }
    }

    return playsong;
  }

  playlisSongDeleteFunction() {}
}
