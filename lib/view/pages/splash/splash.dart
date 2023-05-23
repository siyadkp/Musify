import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../bottomnavigation_page/bottomnavigation_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    navigat();
  }

  navigat() async {
    await Future.delayed(const Duration(milliseconds: 4150));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavigationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 2,
        color: Colors.deepPurple[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Lottie.asset(
                  'assets/animation/Music App Loader.json',
                  width: 400,
                  height: 400,
                  fit: BoxFit.fill,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
