import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:you_tube_downloader/models/audio_model.dart';
import 'package:you_tube_downloader/utils/audio_player_utils.dart';
import 'package:you_tube_downloader/utils/custom_audio_source.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeMusicsApiRepo {
  static final YoutubeMusicsApiRepo _instance = YoutubeMusicsApiRepo._();
  static final _youtube = YoutubeExplode();

  final StreamController<List<AudioModel>> _controller =
      StreamController<List<AudioModel>>();

  Stream<List<AudioModel>> get stream => _controller.stream;

  static List<AudioModel> audiosList = [];

  YoutubeMusicsApiRepo._();

  factory YoutubeMusicsApiRepo() {
    return _instance;
  }

  Future<List<AudioModel>> getAudiosFromChannel(String channelId) async {
    // List<AudioModel> audiosList = [];
    ChannelUploadsList videos =
        await _youtube.channels.getUploadsFromPage(channelId);

    List<Future> futureTasks = [];
    for (var video in videos) {
      futureTasks.add(addAudio(video));
    }

    await Future.wait(futureTasks);

    return audiosList;
  }

  Future addAudio(Video video) async {
    List<int> musicBytes = [];

    StreamManifest data =
        await _youtube.videos.streamsClient.getManifest(video.id);

    AudioOnlyStreamInfo infoStream = data.audioOnly.withHighestBitrate();

    Stream<List<int>> stream = _youtube.videos.streamsClient.get(infoStream);

    await for (final bytes in stream) {
      musicBytes.addAll(bytes);
    }

    AudioSource audioSource = MyCustomSource(musicBytes);
    String videoTitle = video.title;
    if (video.title.contains("[")) {
      videoTitle = video.title.split('[').first;
    } else if (video.title.contains("(")) {
      videoTitle = video.title.split("(").first;
    }
    AudioModel audioModel =
        AudioModel(title: videoTitle, audioSource: audioSource);
    AudioPlayerUtils.playlist.add(audioSource);
    audiosList.add(audioModel);

    _controller.sink.add(audiosList);
  }
}
