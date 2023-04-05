import 'package:flutter/material.dart';
import 'package:myapp/controller/get_allsongs_controler.dart';
import 'package:myapp/functions/mostly_functions.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/page-1/playnow/playnow.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostlyScreen extends StatefulWidget {
  const MostlyScreen({
    super.key,
  });

  @override
  State<MostlyScreen> createState() => _MostlyScreenState();
}

class _MostlyScreenState extends State<MostlyScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongDbModel> mostly = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        // playlist4VN (2:68)
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 2,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/page-1/images/playlist.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white54,
                          size: 35,
                        )),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text('Mostly played',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                Expanded(
                  child: FutureBuilder(
                    future: MostlyFunctions.displayMostly(),
                    builder: (context, item) {
                      return ValueListenableBuilder(
                        valueListenable: MostlyFunctions.mostNotifier,
                        builder: (context, value, child) {
                          if (value.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  'Your Mostly Played Is Empty',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white60),
                                ),
                              ),
                            );
                          } else {
                            final temp = value.reversed.toList();
                            mostly = temp.toSet().toList();
                            return FutureBuilder(
                              future: _audioQuery.querySongs(
                                  sortType: null,
                                  orderType: OrderType.ASC_OR_SMALLER,
                                  uriType: UriType.EXTERNAL,
                                  ignoreCase: true),
                              builder: (context, item) {
                                if (item.data == null) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (item.data!.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      'No Songs In Your Internal',
                                      style: TextStyle(
                                          color: Colors.white60,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: mostly.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: QueryArtworkWidget(
                                        id: mostly[index].id,
                                        type: ArtworkType.AUDIO,
                                        artworkHeight: 60,
                                        artworkWidth: 60,
                                        nullArtworkWidget: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Icon(
                                            Icons.music_note,
                                            color: Colors.white60,
                                          ),
                                        ),
                                        artworkBorder:
                                            BorderRadius.circular(10),
                                        artworkFit: BoxFit.cover,
                                      ),
                                      title: Text(
                                          mostly[index].displayNameWOExt,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              color: Colors.white70)),
                                      subtitle: Text(
                                        mostly[index].artist,
                                        style: const TextStyle(
                                            color: Colors.white70),
                                        maxLines: 1,
                                      ),
                                      onTap: () {
                                        Getallsongs.audioPlayer.setAudioSource(
                                            Getallsongs.createsongslist(
                                                mostly));
                                        Getallsongs.audioPlayer.play();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PlayNowPage(
                                                        songsModel: Getallsongs
                                                            .playsong)));
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
