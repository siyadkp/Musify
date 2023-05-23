import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/controller/provider/play_now/player_controller_provider.dart';
import 'package:provider/provider.dart';

class SongDurationsController extends StatelessWidget {
  const SongDurationsController({
    super.key,
    required this.position,
    required this.duration,
  });

  final Duration position;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerControllerNotifier>(
      builder: (context, playerControllerNotifier, _) {
        return Column(
          children: [
            Slider(
                thumbColor: Colors.white,
                activeColor: Colors.white70,
                inactiveColor: Colors.grey,
                min: const Duration(microseconds: 0).inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                max: duration.inSeconds.toDouble(),
                onChanged: (value) {
                  playerControllerNotifier.chagetoseconds(value.toInt());
                  value = value;
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    position.toString().split('.')[0],
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    duration.toString().split('.')[0],
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
