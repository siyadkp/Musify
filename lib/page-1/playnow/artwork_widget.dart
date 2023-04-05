import 'package:flutter/material.dart';
import 'package:myapp/functions/allsong_db_functions.dart';
import 'package:myapp/page-1/playnow/playnow.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtworkWidget extends StatelessWidget {
  final PlayNowPage widget;
  final int currentindex;
  const ArtworkWidget(
      {super.key, required this.widget, required this.currentindex});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: QueryArtworkWidget(
          keepOldArtwork: true,
          id: resulted[currentindex].id,
          type: ArtworkType.AUDIO,
          artworkWidth: 250,
          artworkHeight: 250,
          artworkFit: BoxFit.cover,
          artworkBorder: const BorderRadius.all(
            Radius.circular(30),
          ),
          nullArtworkWidget: Container(
              height: 250,
              width: 250,
              decoration: const BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: const Icon(
                Icons.music_note,
                size: 120,
                color: Colors.white60,
              )),
        ),
      ),
    );
  }
}
