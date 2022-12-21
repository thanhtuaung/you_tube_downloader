import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:you_tube_downloader/models/audio_model.dart';
import 'package:you_tube_downloader/repo/youtube_musics_api_repo.dart';
import 'package:you_tube_downloader/ui/src/const_widgets.dart';
import 'package:you_tube_downloader/ui/src/constants.dart';
import 'package:you_tube_downloader/ui/src/extensions/context_extension.dart';
import 'package:you_tube_downloader/utils/audio_player_utils.dart';

class MusicPlayerScreen extends StatefulWidget {
  MusicPlayerScreen({Key? key}) : super(key: key);

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  AudioPlayerUtils audioPlayerUtils = AudioPlayerUtils();
  AudioModel? audioModel;

  @override
  void initState() {
    // changeSongName();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(40),
                width: double.infinity,
                height: context.screenHeight * 0.35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 30),
              _musicPlayerWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _musicPlayerWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.music_note,
              size: 35,
              color: Colors.white,
            ),
            StreamBuilder<int?>(
                stream: AudioPlayerUtils.player.currentIndexStream,
                builder: (context, snapshot) {
                  int index = snapshot.data ?? 0;
                  audioModel = YoutubeMusicsApiRepo.audiosList[index];
                  return Text(
                    audioModel?.title ?? 'Song Name',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  );
                }),
          ],
        ),
        const SizedBox(height: 40),
        StreamBuilder<Duration>(
            stream: AudioPlayerUtils.player.positionStream,
            builder: (context, snapshot) {
              int currentPosition = (snapshot.data ?? Duration.zero).inSeconds;
              int duration =
                  (AudioPlayerUtils.player.duration ?? Duration.zero).inSeconds;

              return Slider(
                value: currentPosition / duration,
                onChanged: (value) {
                  Duration current =
                      Duration(seconds: (duration * value).floor());
                  AudioPlayerUtils.player.seek(current);
                },
                // backgroundColor: Colors.amber,
              );
            }),
        ConstantWidgets.sizedBoxHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<Duration>(
                stream: AudioPlayerUtils.player.positionStream,
                initialData: Duration.zero,
                builder: (context, snapshot) {
                  int minutes = 0;
                  int seconds = 0;
                  Duration duration = snapshot.data ?? Duration.zero;
                  int inSeconds = duration.inSeconds;
                  minutes = inSeconds ~/ 60;
                  seconds = inSeconds % 60;
                  return Text(
                    '$minutes : ${seconds < 10 ? "0$seconds" : '$seconds'}',
                    style: TextStyle(color: Colors.amber),
                  );
                }),
            StreamBuilder<Duration?>(
                stream: AudioPlayerUtils.player.durationStream,
                builder: (context, snapshot) {
                  int minutes = 0;
                  int seconds = 0;
                  Duration duration = snapshot.data ?? Duration.zero;
                  int inSeconds = duration.inSeconds;
                  minutes = inSeconds ~/ 60;
                  seconds = inSeconds % 60;
                  return Text(
                    '$minutes : ${seconds < 10 ? "0$seconds" : '$seconds'}',
                    style: const TextStyle(color: Colors.amber),
                  );
                }),
          ],
        ),
        ConstantWidgets.sizedBoxHeightL,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<LoopMode>(
                stream: AudioPlayerUtils.player.loopModeStream,
                builder: (context, snapshot) {
                  LoopMode loopMode = snapshot.data ?? LoopMode.all;
                  return playerIcon(
                      loopMode == LoopMode.all
                          ? Icons.repeat_sharp
                          : loopMode == LoopMode.one
                              ? Icons.repeat_one_outlined
                              : Icons.repeat_sharp, () {
                    if (loopMode == LoopMode.all) {
                      AudioPlayerUtils.player.setLoopMode(LoopMode.one);
                    } else if (loopMode == LoopMode.one) {
                      AudioPlayerUtils.player.setLoopMode(LoopMode.off);
                    } else {
                      AudioPlayerUtils.player.setLoopMode(LoopMode.all);
                    }
                  });
                }),
            playerIcon(Icons.skip_previous, () {
              AudioPlayerUtils.player.seekToPrevious();
            }),
            IconButton(
              onPressed: () {
                PlayerState state = AudioPlayerUtils.player.playerState;
                if (state.playing) {
                  AudioPlayerUtils.player.pause();
                } else {
                  AudioPlayerUtils.player.play();
                }
              },
              icon: StreamBuilder<bool>(
                  stream: AudioPlayerUtils.player.playingStream,
                  builder: (context, snapshot) {
                    bool isPlaying = snapshot.data ?? false;
                    return Icon(isPlaying
                        ? Icons.pause_circle_filled_sharp
                        : Icons.play_circle_fill);
                  }),
              iconSize: 50,
              color: Colors.amber,
            ),
            playerIcon(Icons.skip_next, () {
              AudioPlayerUtils.player.seekToNext();
            }),
            playerIcon(Icons.tune, () {}),
          ],
        )
      ],
    );
  }

  Widget playerIcon(IconData iconData, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        size: 35,
        color: Colors.amber,
      ),
    );
  }

  changeSongName() {
    AudioPlayerUtils.player.currentIndexStream.listen((position) {
      audioModel = YoutubeMusicsApiRepo.audiosList[position ?? 0];
      setState(() {});
    });
    AudioPlayerUtils.player.play();
  }
}
