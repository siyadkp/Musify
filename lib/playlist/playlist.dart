import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/functions/playlistdatabase.dart';
import 'package:myapp/model/model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'playlistindividual.dart';

class Playlistwidget extends StatefulWidget {
  const Playlistwidget({super.key});

  @override
  State<Playlistwidget> createState() => _PlaylistwidgetState();
}

final GlobalKey<FormState> formkey = GlobalKey<FormState>();
final playlistnamecontroller = TextEditingController();

class _PlaylistwidgetState extends State<Playlistwidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: DecoratedBox(
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white38,
                          )),
                    ),
                    const Text(
                      'Playlist',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 200),
                      child: IconButton(
                          onPressed: () {
                            newplaylist(context, formkey);
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.white38,
                            size: 40,
                          )),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ValueListenableBuilder(
                        valueListenable:
                            Hive.box<Playermodel>('playlistDb').listenable(),
                        builder: (BuildContext context,
                            Box<Playermodel> musiclist, Widget? child) {
                          if (musiclist.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 300, left: 120),
                              child: Text(
                                'Add playlist',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 25),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: musiclist.length,
                              itemBuilder: (context, index) {
                                final data = musiclist.values.toList()[index];
                                return Slidable(
                                  endActionPane: ActionPane(
                                    motion: const BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        spacing: 0,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        onPressed: (context) {
                                          DeletePlaylist(
                                              context, musiclist, index);
                                        },
                                        icon: Icons.delete_outline,
                                        foregroundColor: Colors.red,
                                        backgroundColor: Colors.transparent,
                                      ),
                                      SlidableAction(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        onPressed: (context) {
                                          EditPlaylistName(
                                              context, data, index);
                                        },
                                        icon: Icons.edit,
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Colors.white30)),
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Playlisttoaddsong(
                                                      sindex: index,
                                                      playlist: data),
                                            ),
                                          );
                                        },
                                        leading: const Icon(
                                          Icons.music_note_outlined,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                        title: Text(
                                          data.name,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                        trailing: IconButton(
                                          tooltip: 'Drag Left',
                                          icon: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {},
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
      ),
    );
  }

  //function
//show dialog in create playlist
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();

Future<dynamic> EditPlaylistName(
    BuildContext context, Playermodel data, int index) {
  nameController = TextEditingController(text: data.name);
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: Color.fromARGB(255, 52, 6, 105),
      children: [
        SimpleDialogOption(
          child: Text(
            "Edit Playlist '${data.name}'",
            style: const TextStyle(
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
            key: _formKey,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: nameController,
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
                Navigator.pop(ctx);
                nameController.clear();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final name = nameController.text.trim();
                  if (name.isEmpty) {
                    return;
                  } else {
                    final playlistName = Playermodel(name: name, songid: []);
                    PlaylistDb.editList(index, playlistName);
                  }
                  nameController.clear();
                  Navigator.pop(ctx);
                }
              },
              child: const Text(
                'Update',
                style: TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Future<dynamic> DeletePlaylist(
    BuildContext context, Box<Playermodel> musicList, int index) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 52, 6, 105),
        title: const Text(
          'Delete Playlist',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        content: const Text('Are you sure you want to delete this playlist?',
            style: TextStyle(
              color: Colors.white,
            )),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No',
                style: TextStyle(
                  color: Colors.purpleAccent,
                )),
          ),
          TextButton(
            onPressed: () {
              musicList.deleteAt(index);
              Navigator.pop(context);
              const snackBar = SnackBar(
                backgroundColor: Colors.black,
                content: Text(
                  'Playlist is deleted',
                  style: TextStyle(color: Colors.white),
                ),
                duration: Duration(milliseconds: 350),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Text('Yes',
                style: TextStyle(
                  color: Colors.purpleAccent,
                )),
          ),
        ],
      );
    },
  );
}

Future newplaylist(BuildContext context, _formKey) {
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: Color.fromARGB(255, 52, 6, 105),
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
            key: _formKey,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: nameController,
              maxLength: 15,
              decoration: InputDecoration(
                  counterStyle: TextStyle(
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
                nameController.clear();
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
                if (_formKey.currentState!.validate()) {
                  saveButtonPressed(context);
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

Future<void> saveButtonPressed(context) async {
  final name = nameController.text.trim();
  final music = Playermodel(name: name, songid: []);
  final datas = PlaylistDb.playlistDb.values.map((e) => e.name.trim()).toList();
  if (name.isEmpty) {
    return;
  } else if (datas.contains(music.name)) {
    const snackbar3 = SnackBar(
        duration: Duration(milliseconds: 750),
        backgroundColor: Colors.black,
        content: Text(
          'playlist already exist',
          style: TextStyle(color: Colors.redAccent),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar3);
    Navigator.of(context).pop();
  } else {
    PlaylistDb.addPlaylist(music);
    const snackbar4 = SnackBar(
        duration: Duration(milliseconds: 750),
        backgroundColor: Colors.black,
        content: Text(
          'playlist created successfully',
          style: TextStyle(color: Colors.white),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar4);
    Navigator.pop(context);
    nameController.clear();
  }
}
