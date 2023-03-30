import 'package:flutter/material.dart';
import 'package:myapp/functions/playlist/playlistdatabase.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'playlistindividual.dart';

class Playlistwidget extends StatefulWidget {
  const Playlistwidget({super.key});

  @override
  State<Playlistwidget> createState() => _PlaylistwidgetState();
}

final GlobalKey<FormState> formkey = GlobalKey<FormState>();
TextEditingController _playlistnamecontroller = TextEditingController();

class _PlaylistwidgetState extends State<Playlistwidget> {
  @override
  void initState() {
    super.initState();
    PlaylistDB.getAllPlaylist();
  }

  @override
  Widget build(BuildContext context) {
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white38,
                        )),
                  ),
                  const Text(
                    'Playlist',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 200),
                    child: IconButton(
                        onPressed: () {
                          newplaylist(context, formkey);
                        },
                        icon: const Icon(
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
                      valueListenable: PlaylistDB.playlistNotifiier,
                      builder: (BuildContext context, palylistNameList,
                          Widget? child) {
                        if (palylistNameList.isEmpty) {
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
                            itemCount: palylistNameList.length,
                            itemBuilder: (context, index) {
                              // final data = PlaylistDB.playlistSongGet(index);
                              return Slidable(
                                endActionPane: ActionPane(
                                  motion: const BehindMotion(),
                                  children: [
                                    SlidableAction(
                                      spacing: 0,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      onPressed: (context) {
                                        deletePlaylist(context, index);
                                      },
                                      icon: Icons.delete_outline,
                                      foregroundColor: Colors.red,
                                      backgroundColor: Colors.transparent,
                                    ),
                                    SlidableAction(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      onPressed: (context) {
                                        editPlaylistName(context,
                                            palylistNameList[index], index);
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
                                        borderRadius: BorderRadius.circular(15),
                                        border:
                                            Border.all(color: Colors.white30)),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Playlisttoaddsong(
                                              playlistIndex: index,
                                              playlistName:
                                                  palylistNameList[index],
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
                                        palylistNameList[index],
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
    );
  }

  //function
//show dialog in create playlist
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController _editplaylistnameController = TextEditingController();

Future<dynamic> editPlaylistName(
    BuildContext context, String oldPlaylistName, int index) {
  _editplaylistnameController = TextEditingController(text: oldPlaylistName);
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: const Color.fromARGB(255, 52, 6, 105),
      children: [
        SimpleDialogOption(
          child: Text(
            "Edit Playlist '$oldPlaylistName'",
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
              controller: _editplaylistnameController,
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
                _editplaylistnameController.clear();
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
                  if (oldPlaylistName.isEmpty) {
                    return;
                  } else {
                    PlaylistDB.editList(
                        index,
                        _editplaylistnameController.text.trim(),
                        oldPlaylistName);
                    // PlaylistDB.editList(index, playlistName);
                  }
                  _editplaylistnameController.clear();
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

Future<dynamic> deletePlaylist(BuildContext context, int index) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 52, 6, 105),
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
              PlaylistDB.deletePlaylist(index);
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
                // if (_formKey.currentState!.validate()) {
                saveButtonPressed(context, _playlistnamecontroller);
                // }
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

Future<void> saveButtonPressed(context, playlistname) async {
  final name = playlistname.text.trim();
  bool condition = PlaylistDB.playlistNameChecking(name);
  if (name.isEmpty) {
    return;
  } else if (condition == true) {
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
    PlaylistDB.addPlaylist(name);
    const snackbar4 = SnackBar(
        duration: Duration(milliseconds: 750),
        backgroundColor: Colors.black,
        content: Text(
          'playlist created successfully',
          style: TextStyle(color: Colors.white),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar4);
    Navigator.pop(context);
    _playlistnamecontroller.clear();
  }
}
