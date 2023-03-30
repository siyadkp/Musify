import 'package:just_audio/just_audio.dart';
import 'package:myapp/model/model.dart';
import 'package:just_audio_background/just_audio_background.dart';

class Getallsongs {
  static AudioPlayer audioPlayer = AudioPlayer();
  static List<SongDbModel> playsong = [];
  static List<SongDbModel> copysong = [];
  static int currentindexgetallsongs = -1;
  static ConcatenatingAudioSource createsongslist(List<SongDbModel> element) {
    List<AudioSource> songlist = [];
    playsong = element;
    for (var elements in element) {
      songlist.add(AudioSource.uri(Uri.parse(elements.uri),
          tag: MediaItem(
              id: elements.id.toString(),
              title: 'No title',
              album: 'No album',
              artist: elements.artist,
              artUri: Uri.parse(elements.id.toString()))));
    }
    return ConcatenatingAudioSource(children: songlist);
  }
}
