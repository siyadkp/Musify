import 'package:flutter/material.dart';
import 'package:myapp/controller/provider/recently_play/recently_play.dart';
import 'package:myapp/model/model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class RecentlyPlayed extends StatelessWidget {
  RecentlyPlayed({super.key});

  List<SongDbModel> recent = [];

  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Consumer<RecentlyPlayedNotifier>(
        builder: (context, recentlyPlayedNotifier, _) {
      if (recentlyPlayedNotifier.recentlyplayed.isEmpty && recent.isEmpty) {
        return const Center(
          child: Text(
            "Your Recent Is Empty",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(147, 255, 255, 255)),
          ),
        );
      } else {
        recent = recentlyPlayedNotifier.recentSongsResult.reversed.toList();
        return FutureBuilder(
          future: _audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true),
          builder: (context, items) {
            if (items.data == null) {
              const CircularProgressIndicator();
            } else if (items.data!.isEmpty) {
              return const Center(
                child: Text('No songs in your internal'),
              );
            }
            return ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recentlyPlayedNotifier.recentSongsResult.length,
              itemBuilder: (context, index) => ListTile(
                leading: QueryArtworkWidget(
                  id: recentlyPlayedNotifier.recentSongsResult[index].id,
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
                title: Text(recent[index].displayNameWOExt,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Color.fromARGB(208, 255, 255, 255))),
                subtitle: Text(
                  recent[index].artist,
                  style: const TextStyle(color: Colors.white54),
                  maxLines: 1,
                ),
              ),
            );
          },
        );
      }
    });
  }
}
