import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/controller/provider/fav_provider/fav_povider.dart';
import 'package:myapp/controller/provider/mostly_played_provider/mostly_played_provider.dart';
import 'package:myapp/controller/provider/play_now/play_now.dart';
import 'package:myapp/controller/provider/play_now/player_controller_provider.dart';
import 'package:myapp/controller/provider/playlist_provider/playlist_all_songs.dart';
import 'package:myapp/controller/provider/playlist_provider/playlist_provider.dart';
import 'package:myapp/controller/provider/recently_play/recently_play.dart';
import 'package:myapp/controller/provider/search_provider/search_provider.dart';
import 'package:myapp/model/model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'controller/provider/provider.dart';
import 'view/pages/splash/splash.dart';

Future<void> main() async {
  SplashPage splashPage = const SplashPage();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(SongDbModelAdapter().typeId)) {
    Hive.registerAdapter(SongDbModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayermodelAdapter().typeId)) {
    Hive.registerAdapter(PlayermodelAdapter());
  }
  await Hive.openBox<SongDbModel>('songs');
  await Hive.openBox('most_db');
  await Hive.openBox<SongDbModel>('most_db_result');
  await Hive.openBox<SongDbModel>('FavoriteDB');
  await Hive.openBox('playlistDb');
  await Hive.openBox<Playermodel>('Playlist_SongDB');
  await Hive.openBox<int>('recentSongNotifier');

  runApp(ChangeNotifierProvider(
      create: (context) => Songmodelprovider(), child: const MyApp()));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FavNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlaylistNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlaylistAllSongsDisplayNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => MostlyNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => RecentlyPlayedNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlayNowNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlayerControllerNotifier(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Scaffold(body: SplashPage()),
      ),
    );
  }
}
