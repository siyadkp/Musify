import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myapp/allmusic/allmusic.dart';
import 'package:myapp/controller/get_allsongs_controler.dart';
import 'package:myapp/functions/fav_functions.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/page-1/playnow/playnow.dart';
import 'package:myapp/playlist/playlist.dart';

import 'package:on_audio_query/on_audio_query.dart';

class Allmusiclisttile extends StatefulWidget {
  Allmusiclisttile({
    super.key,
    required this.songmodel,
  });
  List<SongModel> songmodel = [];

  @override
  State<Allmusiclisttile> createState() => _AllmusiclisttileState();
}

class _AllmusiclisttileState extends State<Allmusiclisttile> {
  List<SongModel> songs = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        songs.addAll(widget.songmodel);
        return SizedBox(
          height: 65,
          child: ListTile(
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
                maxLines: 1, style: const TextStyle(color: Colors.white70)),
            subtitle: Text(
              '${widget.songmodel[index].artist}',
              style: const TextStyle(color: Colors.white70),
              maxLines: 1,
            ),
            trailing: PopupMenuButton(
              color: const Color.fromARGB(255, 255, 255, 255),
              icon: const Icon(
                Icons.more_vert,
                size: 20,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Container(
                    child: const Text(
                      'Add playlist',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: 'poppins'),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text(
                    FavoriteDB.isFavor(widget.songmodel[index])
                        ? 'Remove Favorites'
                        : 'Add Favorites',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 39, 33, 55),
                    ),
                  ),
                ),
                PopupMenuItem(child: Container(child: const Text('Share'))),
                const PopupMenuItem(
                  child: Text('Song Info'),
                ),
              ],
              onSelected: (value) {
                if (value == 1) {
                  showPlaylistdialog(context, startsong[index]);
                } else if (value == 2) {
                  if (FavoriteDB.isFavor(widget.songmodel[index])) {
                    FavoriteDB.delete(widget.songmodel[index].id);
                    const remove = SnackBar(
                      backgroundColor: Color.fromARGB(222, 38, 46, 67),
                      content: Center(
                        child: Text(
                          'Song Removed In Favorate List',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70),
                        ),
                      ),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(remove);
                  } else {
                    FavoriteDB.add(widget.songmodel[index]);
                    const add = SnackBar(
                      backgroundColor: Color.fromARGB(222, 38, 46, 67),
                      content: Center(
                          child: Center(
                        child: Text(
                          'Song Added In Favorate List',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70),
                        ),
                      )),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(add);
                  }
                  FavoriteDB.favoriteSongs.notifyListeners();
                }
              },
            ),
            onTap: () {
              Getallsongs.audioPlayer.setAudioSource(
                  Getallsongs.createsongslist(widget.songmodel),
                  initialIndex: index);
              // context
              //     .read<Songmodelprovider>()
              //     .setid(widget.songmodel[index].id);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlayNowPage(
                      songsModel: widget.songmodel,
                      count: widget.songmodel.length)));
            },
          ),
        );
      },
      itemCount: widget.songmodel.length,
    );
  }
}

showPlaylistdialog(BuildContext context, SongModel songModel) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 52, 6, 105),
          title: const Text(
            "choose your playlist",
            style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
          ),
          content: SizedBox(
            height: 200,
            width: double.maxFinite,
            child: ValueListenableBuilder(
                valueListenable:
                    Hive.box<Playermodel>('playlistDb').listenable(),
                builder: (BuildContext context, Box<Playermodel> musicList,
                    Widget? child) {
                  return Hive.box<Playermodel>('playlistDb').isEmpty
                      ? Center(
                          child: Stack(
                            children: const [
                              Positioned(
                                right: 30,
                                left: 30,
                                bottom: 50,
                                child: Text('No Playlist found!',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        fontFamily: 'poppins')),
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: musicList.length,
                          itemBuilder: (ctx, index) {
                            final data = musicList.values.toList()[index];

                            return Card(
                              color: const Color.fromARGB(255, 51, 2, 114),
                              shadowColor: Colors.purpleAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: Colors.white)),
                              child: ListTile(
                                title: Text(
                                  data.name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'poppins'),
                                ),
                                trailing: const Icon(
                                  Icons.playlist_add,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  songaddtoplaylist(
                                      songModel, data, data.name, ctx);
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
                  style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'cancel',
                  style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
                ))
          ],
        );
      });
}

void songaddtoplaylist(
    SongModel data, datas, String name, BuildContext context) {
  if (!datas.isvalule(data.id)) {
    datas.add(data.id);
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
                fontFamily: 'poppins',
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
              controller: nameController,
              maxLength: 15,
              decoration: InputDecoration(
                  counterStyle: const TextStyle(
                      color: Colors.white, fontFamily: 'poppins'),
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.only(left: 15, top: 5)),
              style: const TextStyle(
                  fontFamily: 'poppins',
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
                nameController.clear();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  saveButtonPressed(context);
                }
              },
              child: const Text(
                'Create',
                style: TextStyle(
                    fontFamily: 'poppins',
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
