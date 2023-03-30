import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/model/model.dart';

import 'package:myapp/page-1/splash.dart';
import 'package:myapp/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
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
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(body: SplashPage()),
    );
  }
}
