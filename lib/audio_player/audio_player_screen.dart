import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:best_nail/audio_player/position_data.dart';
import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../utils/app_color.dart';
import '../utils/dimesions.dart';
import 'audio_image_slider.dart';
import 'controls.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String url;
  final List<String> images;
  final String title;
  const AudioPlayerScreen(
      {super.key,
      required this.url,
      required this.images,
      required this.title});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  late AudioSource audioSource;

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));
  @override
  void initState() {
    audioSource = AudioSource.uri(Uri.parse(widget.url));
    _audioPlayer = AudioPlayer()..setAudioSource(audioSource);

    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  bool isplaying = false;
  bool iscomplete = false;
  int activeindex = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimesion.radius15) / 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AudioImageSlider(
            images: widget.images,
            activeIndex: activeindex,
            onPageChanged: (val, _) {
              setState(() {
                activeindex = val;
              });
            },
          ),
          SizedBox(
            height: Dimesion.height10,
          ),
          Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          StreamBuilder(
              stream: _positionDataStream,
              builder: ((context, snapshot) {
                final positionData = snapshot.data;

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimesion.width20),
                  child: ProgressBar(
                    barHeight: Dimesion.width5,
                    baseBarColor: Colors.grey[600],
                    bufferedBarColor: Colors.grey,
                    thumbColor: AppColor.primaryClr,
                    progressBarColor: AppColor.primaryClr,
                    timeLabelTextStyle: Theme.of(context).textTheme.labelSmall,
                    progress: positionData?.position ?? Duration.zero,
                    buffered: positionData?.bufferedPosition ?? Duration.zero,
                    total: positionData?.duration ?? Duration.zero,
                    onSeek: _audioPlayer.seek,
                  ),
                );
              })),
          Controls(audioPlayer: _audioPlayer),
          SizedBox(
            height: Dimesion.height10,
          ),
        ],
      ),
    );
  }
}
