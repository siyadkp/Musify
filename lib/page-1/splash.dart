import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/bottomnavigation_page/bottomnavigation_page.dart';
import 'package:lottie/lottie.dart';

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
      MaterialPageRoute(builder: (context) => const BottomNavigationPage()),
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
                // Image.asset(
                //   'assets/page-1/images/sound-waves-1.png',
                //   width: MediaQuery.of(context).size.width *
                //       0.7, // Set width to 70% of the screen width
                // ),
              ],
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: MediaQuery.of(context).size.width *
            //         0.1, // Set horizontal padding to 10% of the screen width
            //   ),
            //   child: LinearProgressIndicator(
            //     backgroundColor: Colors.grey,
            //     valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            //     value: _progressValue,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // void _updateProgress() {
  //   const oneSec = Duration(milliseconds: 500);
  //   Timer.periodic(oneSec, (Timer t) {
  //     setState(() {
  //       _progressValue += 0.3;
  //       // we "finish" downloading here
  //       if (_progressValue.toStringAsFixed(1) == '1.0') {
  //         t.cancel();
  //         return;
  //       }
  //     });
  //   });
  // }
}
