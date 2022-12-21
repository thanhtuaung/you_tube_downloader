import 'package:just_audio/just_audio.dart';

class AudioModel {
  String? title;
  AudioSource? audioSource;

  AudioModel({
    this.title,
    this.audioSource,
  });

  AudioModel copyWith({
    String? title,
    AudioSource? audioSource,
  }) {
    return AudioModel(
      title: title ?? this.title,
      audioSource: audioSource ?? this.audioSource,
    );
  }
}