import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Musify'),
        backgroundColor: const Color.fromARGB(255, 20, 5, 46),
      ),
      backgroundColor: const Color.fromARGB(255, 20, 5, 46),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Welcome to Musify App, make your life more live.We are dedicated to providing you the very best quality of sound and the music varient,with an emphasis on new features. playlists and favourites,and a rich user experience\n\n Founded in 2023 by Muhammad Siyad . Musify app is our first major project with a basic performance of music hub and creates a better versions in future.Musify gives you the best music experience that you never had. it includes attractivemode of UI\'s and good practices.\n\nIt gives good quality and had increased the settings to power up the system as well as to provide better music rythms.\n\nWe hope you enjoy our music as much as we enjoy offering them to you.If you have any questions or comments, please don\'t hesitate to contact us.\n\nSincerely,\n\nMuhammad Siyad',
          style: TextStyle(fontSize: 13, color: Colors.white),
        ),
      ),
    );
  }
}
