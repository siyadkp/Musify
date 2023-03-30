import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/model/model.dart';
import 'package:myapp/page-1/settings/about_screen.dart';
import 'package:myapp/page-1/settings/terms_condition_screen.dart';

import 'privacy_policy_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 2,
      child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/page-1/images/home.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white30,
                            size: 35,
                          )),
                      const Text(
                        'Settings',
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontSize: 30),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutScreen(),
                        ));
                  },
                  child: const ListSettings(
                    titleText: 'About Musify',
                    yourIcon: Icons.info_outline,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TermsAndConditionScreen(),
                        ));
                  },
                  child: const ListSettings(
                    titleText: 'Terms and Conditions',
                    yourIcon: Icons.gavel_rounded,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ));
                  },
                  child: const ListSettings(
                    titleText: 'Privacy Policy',
                    yourIcon: Icons.privacy_tip_outlined,
                  ),
                ),
                InkWell(
                  onTap: () {
                    newplaylist(context, 1);
                  },
                  child: const ListSettings(
                    titleText: 'Reset',
                    yourIcon: Icons.cleaning_services_rounded,
                  ),
                ),
                const Center(
                    child: Text(
                  'version1.1.0',
                  style: TextStyle(fontSize: 15, color: Colors.white54),
                ))
              ],
            ),
          )),
    ));
  }

  Future newplaylist(BuildContext context, formKey) {
    return showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        backgroundColor: const Color.fromARGB(255, 52, 6, 105),
        children: [
          const SimpleDialogOption(
            child: Text(
              'This will reset your Application datas',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'CANCEL',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  resetFunctions();
                  Navigator.pop(context);
                },
                child: const Text(
                  'ACCEPT',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  resetFunctions() {
    final favoritedb = Hive.box<SongDbModel>('FavoriteDB');
    final playlistDb = Hive.box('playlistDb');
    final mostDB = Hive.box('most_db');
    final recentDB = Hive.box<int>('recentSongNotifier');
    favoritedb.clear();
    playlistDb.clear();
    mostDB.clear();
    recentDB.clear();
  }
}

class ListSettings extends StatelessWidget {
  const ListSettings({
    Key? key,
    required this.titleText,
    required this.yourIcon,
  }) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final titleText;
  final IconData yourIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        iconColor: Colors.white,
        leading: Icon(yourIcon),
        title: Text(
          titleText,
          style: const TextStyle(
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
              color: Colors.white),
        ),
      ),
    );
  }
}
