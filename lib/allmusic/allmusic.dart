import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:myapp/allmusic/allmusiclist_tile.dart';
import 'package:myapp/functions/allsong_db_functions.dart';
import 'package:myapp/model/model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

List<SongModel> songs = [];

class AllsongsWidget extends StatefulWidget {
  const AllsongsWidget({super.key});

  @override
  State<AllsongsWidget> createState() => _AllsongsWidgetState();
}

class _AllsongsWidgetState extends State<AllsongsWidget> {
  @override
  void initState() {
    super.initState();
    requestPermission();
    final allsongDb = Hive.box<SongDbModel>('songs');
    allsongDb.clear();
  }

  requestPermission() async {
    bool status = await audioqury.permissionsStatus();
    if (!status) {
      await audioqury.permissionsRequest();
    }
    setState(() {});
    Permission.storage.request();
  }

  final audioqury = OnAudioQuery();
  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
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
