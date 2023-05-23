import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:myapp/controller/provider/all_songs_fetching_provider/all_songs_fetching_provider.dart';
import 'package:myapp/model/model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../controller/functions/allsong_db_functions.dart';
import '../../controller/provider/search_provider/search_provider.dart';
import 'allmusiclist_tile.dart';

List<SongModel> songs = [];
Trie trie = Trie();
Map<String, SongDbModel> allsongInMap = {};

class AllsongsWidget extends StatelessWidget {
  AllsongsWidget({super.key});

  @override
  // void initState() {
  //   super.initState();
  //   requestPermission();
  //   final allsongDb = Hive.box<SongDbModel>('songs');
  //   allsongDb.clear();
  // }

  // requestPermission() async {
  //   bool status = await audioqury.permissionsStatus();
  //   if (!status) {
  //     await audioqury.permissionsRequest();
  //   }
  //   setState(() {});
  //   Permission.storage.request();
  // }

  final audioqury = OnAudioQuery();

  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    AllSongFetchingInExternalNotifier allSongFetchingInExternalNotifier =
        AllSongFetchingInExternalNotifier();
    return FutureBuilder<List<SongModel>>(
      future: audioqury.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      ), // set mimeTypes parameter to "audio/mpeg"
      builder: (context, item) {
        if (item.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (item.data!.isEmpty) {
          return const Center(
            child: Text(
              'No songs',
              style: TextStyle(color: Colors.white54),
            ),
          );
        } else {
          songs = item.data!;
          final allsongDb = Hive.box<SongDbModel>('songs');
          allsongDb.clear();

          for (var element in songs) {
            if (element.fileExtension.contains("mp3") &&
                !element.data.contains("/WhatsApp Audio")) {
              if (!element.displayName.contains("AUD")) {
                var value = SongDbModel(
                  id: element.id,
                  data: element.data,
                  uri: element.uri!,
                  displayName: element.displayName,
                  displayNameWOExt: element.displayNameWOExt,
                  artist: element.artist!,
                  artistId: element.artistId!,
                );
                trie.insert(element.displayName.toLowerCase());
                allsongInMap[element.displayName.toLowerCase()] = value;
                SongModelFunctions.addAllsong(value);
              }
            }
          }

          SongModelFunctions.getAllsong();
        }

        return Allmusiclisttile(
          songmodel: resulted,
        );
      },
    );
  }
}
