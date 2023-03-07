import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Container(
          // searchhEG (1:29)
          width: double.infinity,
          height: 800 * fem,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(42 * fem),
          ),
          child: SizedBox(
            // searchBQL (1:34)
            width: 370.81 * fem,
            height: 801 * fem,
            child: Stack(
              children: [
                Positioned(
                  // soundwaves1WxQ (1:35)
                  left: 114 * fem,
                  top: 37 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 37 * fem,
                      height: 33 * fem,
                      child: Image.asset(
                        'assets/page-1/images/sound-waves-1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // frame5MCL (1:36)
                  left: 0 * fem,
                  top: 0 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 370.81 * fem,
                      height: 801 * fem,
                      child: Image.asset(
                        'assets/page-1/images/frame-5.png',
                        width: 370.81 * fem,
                        height: 801 * fem,
                      ),
                    ),
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
