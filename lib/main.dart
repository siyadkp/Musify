import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/page-1/splash.dart';
import 'package:myapp/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  if (!Hive.isAdapterRegistered(PlayermodelAdapter().typeId)) {
    Hive.registerAdapter(PlayermodelAdapter());
    await Hive.initFlutter();
    await Hive.openBox<int>('FavoriteDB');
    await Hive.openBox<Playermodel>('playlistDb');
    runApp(ChangeNotifierProvider(
        create: (context) => Songmodelprovider(), child: MyApp()));
  }
}

class MyApp extends StatelessWidget {
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
