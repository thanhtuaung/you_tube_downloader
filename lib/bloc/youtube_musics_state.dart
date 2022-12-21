part of 'youtube_musics_bloc.dart';

class YoutubeMusicsState {
  final BlocActionStates state;
  List<AudioModel> youtubeAudios;
  String? error;

  YoutubeMusicsState({
    required this.state,
    required this.youtubeAudios,
    this.error,
  });

  YoutubeMusicsState copyWith({
    BlocActionStates? state,
    List<AudioModel>? youtubeAudios,
    String? error,
  }) {
    return YoutubeMusicsState(
      state: state ?? this.state,
      youtubeAudios: youtubeAudios ?? this.youtubeAudios,
      error: error ?? this.error,
    );
  }
}
