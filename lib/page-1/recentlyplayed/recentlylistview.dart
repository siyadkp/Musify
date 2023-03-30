import 'package:flutter/material.dart';
import 'package:myapp/functions/recpaly_functions.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyPlayed extends StatefulWidget {
  const RecentlyPlayed({super.key});

  @override
  State<RecentlyPlayed> createState() => _RecentlyPlayedState();
}

class _RecentlyPlayedState extends State<RecentlyPlayed> {
  List recent = [];
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetRecentlyPlayed.getRecentlySongs(),
        builder: (context, item) {
          return ValueListenableBuilder(
              valueListenable: GetRecentlyPlayed.recentSongNotifier,
              builder: (context, value, child) {
                if (value.isEmpty && recent.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 350, left: 100),
                    child: Text(
                      "Your Recent Is Empty",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(147, 255, 255, 255)),
                    ),
                  );
                } else {
                  recent = value.reversed.toList();
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
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: recent.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: QueryArtworkWidget(
                            id: recent[index].id,
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
                            '${recent[index].artist}',
                            style: const TextStyle(color: Colors.white54),
                            maxLines: 1,
                          ),
                        ),
                      );
                    },
                  );
                }
              });
        });
  }
}
