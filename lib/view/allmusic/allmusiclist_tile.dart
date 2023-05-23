import 'package:flutter/material.dart';
import 'package:myapp/controller/get_allsongs_controler.dart';
import 'package:myapp/controller/provider/fav_provider/fav_povider.dart';
import 'package:myapp/controller/provider/mostly_played_provider/mostly_played_provider.dart';
import 'package:myapp/controller/provider/playlist_provider/playlist_provider.dart';
import 'package:myapp/controller/provider/recently_play/recently_play.dart';
import 'package:myapp/model/model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../controller/functions/allsong_db_functions.dart';
import '../../controller/provider/playlist_provider/playlist_all_songs.dart';
import '../pages/playnow/playnow.dart';
import '../pages/library/playlist/playlist.dart';

class Allmusiclisttile extends StatefulWidget {
  Allmusiclisttile({
    super.key,
    required this.songmodel,
  });

  List<SongDbModel> songmodel = [];

  @override
  State<Allmusiclisttile> createState() => _AllmusiclisttileState();
}

class _AllmusiclisttileState extends State<Allmusiclisttile> {
  List<SongDbModel> songs = [];

  @override
  Widget build(BuildContext context) {
    final recentlyPlayedNotifier =
        Provider.of<RecentlyPlayedNotifier>(context, listen: false);
    final mostlyNotifier = Provider.of<MostlyNotifier>(context, listen: false);

    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        songs.addAll(widget.songmodel);
        return ListTile(
          leading: QueryArtworkWidget(
            id: widget.songmodel[index].id,
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
          title: Text(widget.songmodel[index].displayNameWOExt,
              maxLines: 1,
              style:
                  const TextStyle(color: Color.fromARGB(208, 255, 255, 255))),
          subtitle: Text(
            widget.songmodel[index].artist,
            style: const TextStyle(color: Colors.white54),
            maxLines: 1,
          ),
          trailing:
              Consumer<FavNotifier>(builder: (context, favNotifier, child) {
            return PopupMenuButton(
              color: const Color.fromARGB(255, 255, 255, 255),
              icon: const Icon(
                Icons.more_vert,
                size: 20,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text(
                    'Add playlist',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text(
                    favNotifier.favChecking(widget.songmodel[index])
                        ? 'Remove Favorites'
                        : 'Add Favorites',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 39, 33, 55),
                    ),
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 1) {
                  showPlaylistdialog(context, resulted[index]);
                } else if (value == 2) {
                  favNotifier.favAction(widget.songmodel[index], context);
                }
              },
            );
          }),
          onTap: () {
            FocusScope.of(context).unfocus();
            mostlyNotifier.addToMostly(widget.songmodel[index].id);
            recentlyPlayedNotifier
                .addRecentlyPlayed(widget.songmodel[index].id);
            // GetRecentlyPlayed.addRecentlyPlayed(widget.songmodel[index].id);
            Getallsongs.audioPlayer.setAudioSource(
                Getallsongs.createsongslist(widget.songmodel),
                initialIndex: index);

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PlayNowPage(
                      songsModel: widget.songmodel,

                      // count: widget.songmodel.length
                    )));
          },
        );
      },
      itemCount: widget.songmodel.length,
    );
  }
}

showPlaylistdialog(BuildContext context, SongDbModel song) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 52, 6, 105),
          title: const Text(
            "choose your playlist",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: SizedBox(
            height: 200,
            width: double.maxFinite,
            child: Consumer<PlaylistNotifier>(
                builder: (BuildContext context, playlistNotifier, _) {
              return playlistNotifier.playliatDatas.isEmpty
                  ? const Center(
                      child: Stack(
                        children: [
                          Positioned(
                            right: 30,
                            left: 30,
                            bottom: 50,
                            child: Center(
                              child: Text('No Playlist found!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  )),
                            ),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: playlistNotifier.playliatDatas.length,
                      itemBuilder: (ctx, index) {
                        // final data = musicList.values.toList()[index];

                        return Card(
                          color: const Color.fromARGB(255, 51, 2, 114),
                          shadowColor: Colors.purpleAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.white)),
                          child: ListTile(
                            title: Text(
                              playlistNotifier.playliatDatas[index],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.playlist_add,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Playermodel value = Playermodel(
                                  index: index,
                                  song: song,
                                  playlistName:
                                      playlistNotifier.playliatDatas[index]);
                              songaddtoplaylist(value, context,
                                  playlistNotifier.playliatDatas[index]);
                              Navigator.pop(ctx);
                            },
                          ),
                        );
                      },
                    );
            }),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  newplaylist(context, formkey);
                },
                child: const Text(
                  'New Playlist',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'cancel',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
          ],
        );
      });
}

TextEditingController _playlistnamecontroller = TextEditingController();
void songaddtoplaylist(Playermodel value, BuildContext context, name) {
  PlaylistAllSongsDisplayNotifier playlistAllSongsDisplayNotifier =
      PlaylistAllSongsDisplayNotifier();
  bool condition =
      playlistAllSongsDisplayNotifier.playlistSongChecking(value.song);
  if (condition == false) {
    playlistAllSongsDisplayNotifier.songAddingToPlaylist(
        value.playlistName, value, value.index, context);
    final snake1 = SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: const Color.fromARGB(222, 38, 46, 67),
        content: Center(
            child: Text(
          'Playlist Add To $name',
          style: const TextStyle(color: Colors.white60),
        )));
    ScaffoldMessenger.of(context).showSnackBar(snake1);
  } else {
    final snake2 = SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red,
        content: Center(child: Text('Song Alredy Added In $name')));
    ScaffoldMessenger.of(context).showSnackBar(snake2);
  }
}

Future newplaylist(BuildContext context, formKey) {
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: const Color.fromARGB(255, 52, 6, 105),
      children: [
        const SimpleDialogOption(
          child: Text(
            'New to Playlist',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SimpleDialogOption(
          child: Form(
            key: formKey,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: _playlistnamecontroller,
              maxLength: 15,
              decoration: InputDecoration(
                  counterStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.only(left: 15, top: 5)),
              style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your playlist name";
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
                _playlistnamecontroller.clear();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // saveButtonPressed(context, _playlistnamecontroller);
                }
              },
              child: const Text(
                'Create',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
