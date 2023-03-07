import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:myapp/allmusic/allmusiclist_tile.dart';
import 'package:myapp/functions/fav_functions.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

List<SongModel> startsong = [];

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
          path: '/storage/emulated/0/Musify',
          ignoreCase: true),
      builder: (context, item) {
        if (item.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (item.data!.isEmpty) {
          return const Center(
            child: Text('No songs'),
          );
        }
        startsong = item.data!;
        FavoriteDB.isintialized(item.data!);
        return Allmusiclisttile(
          songmodel: item.data!,
        );
      },
    );
  }
}
