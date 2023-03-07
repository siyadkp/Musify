import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/bottomnavigation_page/bottomnavigation_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late double _progressValue;
  @override
  void initState() {
    super.initState();
    _progressValue = 0.0;

    _updateProgress();
    navigat();
  }

  navigat() async {
    await Future.delayed(const Duration(seconds: 10));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const BottomNavigationPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 410,
        height: 820.5,
        color: Colors.deepPurple[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/page-1/images/sound-waves-1.png',
                  width: 250,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                value: _progressValue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateProgress() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.1;
        // we "finish" downloading here
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          t.cancel();
          return;
        }
      });
    });
  }
}
