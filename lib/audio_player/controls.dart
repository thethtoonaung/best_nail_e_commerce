import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../utils/dimesions.dart';

class Controls extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const Controls({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final playerState =
              snapshot.data ?? PlayerState(false, ProcessingState.completed);
          final processingState = playerState.processingState;
          final playing = playerState.playing;

          if (!playing) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: skipbackword,
                    iconSize: Dimesion.iconSize25 * 1.1,
                    icon: const Icon(
                      Icons.replay_10_rounded,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: audioPlayer.play,
                    iconSize: Dimesion.iconSize25 * 2,
                    icon: const Icon(
                      Icons.play_circle_fill_rounded,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: skipforword,
                    iconSize: Dimesion.iconSize25 * 1.1,
                    icon: const Icon(
                      Icons.forward_10_rounded,
                      color: Colors.black,
                    )),
              ],
            );
          } else if (processingState != ProcessingState.completed) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: skipbackword,
                    iconSize: Dimesion.iconSize25 * 1.1,
                    icon: const Icon(
                      Icons.replay_10_rounded,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: audioPlayer.pause,
                    iconSize: Dimesion.iconSize25 * 2,
                    icon: const Icon(
                      Icons.pause_circle_filled_rounded,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: skipforword,
                    iconSize: Dimesion.iconSize25 * 1.1,
                    icon: const Icon(
                      Icons.forward_10_rounded,
                      color: Colors.black,
                    )),
              ],
            );
          }
          return IconButton(
              onPressed: replay,
              iconSize: Dimesion.iconSize25 * 1.8,
              icon: const Icon(
                Icons.replay,
                color: Colors.black,
              ));
        });
  }

  skipbackword() {
    const backDuration = Duration(seconds: 10);
    audioPlayer.seek(audioPlayer.position - backDuration);
  }

  skipforword() {
    const forwordDuration = Duration(seconds: 10);
    audioPlayer.seek(audioPlayer.position + forwordDuration);
  }

  replay() {
    audioPlayer.seek(Duration.zero);
  }
}
