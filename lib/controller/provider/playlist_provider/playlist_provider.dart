import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'playlist_database/play_list_database.dart';

class PlaylistNotifier with ChangeNotifier {
  PlaylistNotifier() {
    playlisAllDataFetching();
  }
  List playliatDatas = [];
  PlaylistDataBase playlistDataBase = PlaylistDataBase();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController playlistnamecontroller = TextEditingController();
  TextEditingController _editplaylistnameController = TextEditingController();

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
          SizedBox(height: 0.02 * MediaQuery.of(context).size.height),
          SimpleDialogOption(
            child: Form(
              key: formKey,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: playlistnamecontroller,
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
          SizedBox(height: 0.02 * MediaQuery.of(context).size.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  playlistnamecontroller.clear();
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
                  saveButtonPressed(context, playlistnamecontroller);
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
    bool condition = playlistDataChecking(name);
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
      playlistDataBase.addPlaylist(name);
      const snackbar4 = SnackBar(
          duration: Duration(milliseconds: 750),
          backgroundColor: Colors.black,
          content: Text(
            'playlist created successfully',
            style: TextStyle(color: Colors.white),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar4);
      Navigator.pop(context);
      playlistnamecontroller.clear();
      playlisAllDataFetching();
    }
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
          content: const Text(
            'Are you sure you want to delete this playlist?',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
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
                playlistDataBase.deletePlaylist(index);
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
                playlisAllDataFetching();
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
          SizedBox(height: 0.02 * MediaQuery.of(context).size.height),
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
          SizedBox(height: 0.02 * MediaQuery.of(context).size.height),
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
                      playlistDataBase.editList(
                          index,
                          _editplaylistnameController.text.trim(),
                          oldPlaylistName);
                      // PlaylistDB.editList(index, playlistName);
                    }
                    playlisAllDataFetching();
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

  playlistDataChecking(String name) {
    if (playliatDatas.contains(name)) {
      return true;
    } else {
      return false;
    }
  }

  playlisAllDataFetching() {
    playliatDatas.clear();
    playliatDatas.addAll(playlistDataBase.getAllPlaylist());
    notifyListeners();
  }
}
