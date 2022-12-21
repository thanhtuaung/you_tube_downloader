import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';
import 'package:you_tube_downloader/models/audio_model.dart';
import 'package:you_tube_downloader/src/enums.dart';

import '../repo/youtube_musics_api_repo.dart';

part 'youtube_musics_event.dart';

part 'youtube_musics_state.dart';

class YoutubeMusicsBloc extends Bloc<YoutubeMusicsEvent, YoutubeMusicsState> {
  final YoutubeMusicsApiRepo _musicsApiRepo;

  YoutubeMusicsBloc()
      : _musicsApiRepo = YoutubeMusicsApiRepo(),
        super(YoutubeMusicsState(
            state: BlocActionStates.initial, youtubeAudios: [])) {
    on<YoutubeMusicsEvent>(_youtubeMusicsFetchProcess);
  }

  _youtubeMusicsFetchProcess(
      YoutubeMusicsEvent event, Emitter<YoutubeMusicsState> emit) async {
    // emit(state.copyWith(state: BlocActionStates.fetching));
    try {
      List<AudioModel> audioList =
          await _musicsApiRepo.getAudiosFromChannel("UCMF1IZjfEUY2ybMaFQ1eKiA");

      // emit(state.copyWith(
      //     state: BlocActionStates.fetchSuccessed, youtubeAudios: audioList));
    } on Exception catch (e) {
      // emit(state.copyWith(
      //     state: BlocActionStates.fetchFailed, error: e.toString()));
    }
  }
}
