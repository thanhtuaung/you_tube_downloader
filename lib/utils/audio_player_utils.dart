import 'package:just_audio/just_audio.dart';

class AudioPlayerUtils {
  static final AudioPlayerUtils _instance = AudioPlayerUtils._();
  static final player = AudioPlayer();

  static final playlist = ConcatenatingAudioSource(
    // Start loading next item just before reaching it
    useLazyPreparation: true,
    // Customise the shuffle algorithm
    shuffleOrder: DefaultShuffleOrder(),
    // Specify the playlist items
    children: [],
  );

  AudioPlayerUtils._();

  factory AudioPlayerUtils() {
    return _instance;
  }

  static setAudioSource(int index) {
    player.setAudioSource(playlist,
        initialIndex: index, initialPosition: Duration.zero);
  }
}
