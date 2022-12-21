import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_tube_downloader/models/audio_model.dart';
import 'package:you_tube_downloader/ui/pages/home/components/description_row.dart';
import 'package:you_tube_downloader/ui/pages/home/components/header_widget.dart';
import 'package:you_tube_downloader/ui/src/const_widgets.dart';
import 'package:you_tube_downloader/ui/src/extensions/context_extension.dart';

import '../../../bloc/youtube_musics_bloc.dart';
import '../../../repo/youtube_musics_api_repo.dart';
import '../../../utils/audio_player_utils.dart';
import '../../routes/route_list.dart';
import '../../src/constants.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  late YoutubeMusicsBloc _youtubeMusicsBloc;

  @override
  Widget build(BuildContext context) {
    // _youtubeMusicsBloc = context.read<YoutubeMusicsBloc>()
    //   ..add(YoutubeMusicsFetchEvent());

    return Scaffold(
      body: Column(
        children: [
          HeaderWidget(),
          ConstantWidgets.sizedBoxHeightL,
          DescriptionRow(),
          ConstantWidgets.sizedBoxHeight,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 130,
                    height: 100,
                    decoration: BoxDecoration(
                        color: ConstantColors.primaryColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 130,
                    height: 100,
                    decoration: BoxDecoration(
                        color: ConstantColors.primaryColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 130,
                    height: 100,
                    decoration: BoxDecoration(
                        color: ConstantColors.primaryColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ],
              ),
            ),
          ),
          ConstantWidgets.sizedBoxHeightL,
          DescriptionRow(),
          createAudiosList(),
        ],
      ),
    );
  }

  Widget createAudiosList() {
    return StreamBuilder<List<AudioModel>>(
      stream: YoutubeMusicsApiRepo().stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error occur!!"),
          );
        } else if (snapshot.hasData) {
          if ((snapshot.data ?? []).isEmpty) {
            return Center(
              child: Text('No Auidos!'),
            );
          }
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                AudioModel audioModel = snapshot.data![index];
                return ListTile(
                  onTap: () async {
                    // await AudioPlayerUtils.player
                    //     .setAudioSource(audioModel.audioSource!);
                    // AudioPlayerUtils.player.play();
                    AudioPlayerUtils.setAudioSource(index);
                    context.pushNamed(RouteList.musicPlayerScreen);
                  },
                  leading: const CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.music_note_rounded),
                  ),
                  title: Text(
                    audioModel.title ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text("Duration"),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
