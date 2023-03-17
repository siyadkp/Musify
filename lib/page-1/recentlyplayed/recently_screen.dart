import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:myapp/page-1/recentlyplayed/recentlylistview.dart';

class RecentlyScreen extends StatefulWidget {
  const RecentlyScreen({super.key});

  @override
  State<RecentlyScreen> createState() => _RecentlyScreenState();
}

class _RecentlyScreenState extends State<RecentlyScreen> {
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
              child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Text('Recently played',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500)),
              ),
              Expanded(child: RecentlyPlayed())
            ],
          )),
        ),
      ),
    );
  }
}
