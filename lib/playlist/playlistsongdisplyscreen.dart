import 'package:flutter/material.dart';
import 'package:myapp/functions/allsong_db_functions.dart';
import 'package:myapp/functions/playlist/song_add_to_playlist.dart';
import 'package:myapp/model/model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Playlistsongdisplayscreen extends StatefulWidget {
  const Playlistsongdisplayscreen(
      {super.key, required this.playlistIndex, required this.playlistName});
  final int playlistIndex;
  final String playlistName;

  @override
  State<Playlistsongdisplayscreen> createState() =>
      _PlaylistsongdisplayscreenState();
}

final audioquery = OnAudioQuery();

class _PlaylistsongdisplayscreenState extends State<Playlistsongdisplayscreen> {
  // bool condition=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[900],
        appBar: AppBar(
          elevation: 15.0,
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white60,
              )),
          title: const Text(
            'Add Song To Playlist',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        body: FutureBuilder<SongDbModel>(builder: (context, item) {
          if (resulted.isEmpty) {
            return const Center(
                child: Text(
              'No Songs Available',
              style: TextStyle(color: Colors.white),
            ));
          }
          return ListView.builder(
            itemCount: resulted.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: QueryArtworkWidget(
                  id: resulted[index].id,
                  type: ArtworkType.AUDIO,
                  artworkHeight: 60,
                  artworkWidth: 60,
                  nullArtworkWidget: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: const Icon(
                        Icons.music_note,
                        color: Colors.white60,
                      )),
                  artworkBorder: BorderRadius.circular(10),
                  artworkFit: BoxFit.cover,
                ),
                title: Text(resulted[index].displayNameWOExt,
                    maxLines: 1, style: const TextStyle(color: Colors.white70)),
                subtitle: Text(
                  resulted[index].artist,
                  style: const TextStyle(color: Colors.white70),
                  maxLines: 1,
                ),
                trailing: Wrap(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: PlaylistSongDB.playlistSongsNotifer,
                      builder: (context, value, child) {
                        if (!PlaylistSongDB.playlistSongChecking(
                            resulted[index])) {
                          return IconButton(
                            onPressed: () {
                              Playermodel value = Playermodel(
                                  index: index,
                                  song: resulted[index],
                                  playlistName: widget.playlistName);
                              songaddplaylist(
                                  widget.playlistName, value, index);
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white60,
                            ),
                          );
                        } else {
                          return IconButton(
                              onPressed: () {
                                PlaylistSongDB.playlisSongDelete(
                                    widget.playlistName, index);
                                const removesongplaylistsnake = SnackBar(
                                    backgroundColor:
                                        Color.fromARGB(222, 38, 46, 67),
                                    duration: Duration(seconds: 1),
                                    content: Center(
                                        child:
                                            Text('Music Removed In Playlist')));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(removesongplaylistsnake);
                              },
                              icon: const Icon(Icons.remove,
                                  color: Colors.white60));
                        }
                      },
                    )
                  ],
                ),
              );
            },
          );
        }));
  }

  songaddplaylist(String playlistName, song, songIndex) {
    PlaylistSongDB.playlistSongAdd(playlistName, song, songIndex);
    const addsongplaylistsnake = SnackBar(
        backgroundColor: Color.fromARGB(222, 38, 46, 67),
        duration: Duration(seconds: 1),
        content: Center(child: Text('Music Added In Playlist')));
    ScaffoldMessenger.of(context).showSnackBar(addsongplaylistsnake);
  }
}
