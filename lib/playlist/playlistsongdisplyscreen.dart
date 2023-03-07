import 'package:flutter/material.dart';
import 'package:myapp/controller/get_allsongs_controler.dart';
import 'package:myapp/functions/playlistdatabase.dart';
import 'package:myapp/model/model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Playlistsongdisplayscreen extends StatefulWidget {
  const Playlistsongdisplayscreen({
    super.key,
    required this.playlist,
  });
  final Playermodel playlist;

  @override
  State<Playlistsongdisplayscreen> createState() =>
      _PlaylistsongdisplayscreenState();
}

final audioquery = OnAudioQuery();

class _PlaylistsongdisplayscreenState extends State<Playlistsongdisplayscreen> {
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
        body: FutureBuilder<List<SongModel>>(
            future: audioquery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              path: '/storage/emulated/0/Musify',
              ignoreCase: true,
            ),
            builder: (context, item) {
              if (item.data == null) {
                return const CircularProgressIndicator();
              }
              if (item.data!.isEmpty) {
                return const Center(child: Text('No Songs Available'));
              }
              return ListView.builder(
                itemCount: item.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: QueryArtworkWidget(
                      id: item.data![index].id,
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
                    title: Text(item.data![index].displayNameWOExt,
                        maxLines: 1,
                        style: const TextStyle(color: Colors.white70)),
                    subtitle: Text(
                      item.data![index].artist!,
                      style: const TextStyle(color: Colors.white70),
                      maxLines: 1,
                    ),
                    trailing: Wrap(
                      children: [
                        !widget.playlist.isvalule(item.data![index].id)
                            ? IconButton(
                                onPressed: () {
                                  Getallsongs.copysong = item.data!;
                                  setState(() {
                                    songaddplaylist(item.data![index]);
                                    PlaylistDb.playlistNotifiier
                                        .notifyListeners();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white60,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.playlist
                                        .deletedata(item.data![index].id);
                                    const removesongplaylistsnake = SnackBar(
                                        backgroundColor:
                                            Color.fromARGB(222, 38, 46, 67),
                                        duration: Duration(seconds: 1),
                                        content: Center(
                                            child: Text(
                                                'Music Removed In Playlist')));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(removesongplaylistsnake);
                                  });
                                },
                                icon: const Icon(Icons.remove,
                                    color: Colors.white60))
                      ],
                    ),
                  );
                },
              );
            }));
  }

  songaddplaylist(SongModel data) {
    widget.playlist.add(data.id);
    const addsongplaylistsnake = SnackBar(
        backgroundColor: Color.fromARGB(222, 38, 46, 67),
        duration: Duration(seconds: 1),
        content: Center(child: Text('Music Added In Playlist')));
    ScaffoldMessenger.of(context).showSnackBar(addsongplaylistsnake);
  }
}
