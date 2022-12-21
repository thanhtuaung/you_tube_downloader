import 'package:flutter/material.dart';
import 'package:you_tube_downloader/bloc/youtube_musics_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_tube_downloader/models/audio_model.dart';
import 'package:you_tube_downloader/repo/youtube_musics_api_repo.dart';
import 'package:you_tube_downloader/src/enums.dart';
import 'package:you_tube_downloader/ui/routes/route_generator.dart';
import 'package:you_tube_downloader/utils/audio_player_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youtube Downloader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      ),
      onGenerateRoute: onGeneratorRoute,
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  late YoutubeMusicsBloc _youtubeMusicsBloc;

  @override
  Widget build(BuildContext context) {
    _youtubeMusicsBloc = context.read<YoutubeMusicsBloc>();
    return Scaffold(
      backgroundColor: Color(0xFF5342C6),
      // appBar: AppBar(
      //   title: const Text("Youtube Downloader"),
      // ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<List<AudioModel>>(
                stream: YoutubeMusicsApiRepo().stream,
                initialData: [],
                builder: (context, list) => list.hasError
                    ? Center(
                        child: Icon(Icons.error),
                      )
                    : !list.hasData
                        ? Center(
                            child: Text("No Data"),
                          )
                        : (list.data ?? []).isEmpty
                            ? Center(
                                child: Text("Empyt"),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: list.data!.length,
                                  itemBuilder: (context, index) {
                                    AudioModel audioModel = list.data![index];
                                    return ListTile(
                                      onTap: () async {
                                        await AudioPlayerUtils.player
                                            .setAudioSource(
                                                audioModel.audioSource!);
                                        AudioPlayerUtils.player.play();
                                      },
                                      title: Text(
                                        audioModel.title ?? '',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )),
            ElevatedButton(
              onPressed: () async {
                _youtubeMusicsBloc.add(YoutubeMusicsFetchEvent());
              },
              child: Text("Convert"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await AudioPlayerUtils.player.pause();
                  },
                  child: Text("Pause"),
                ),
                const SizedBox(width: 50),
                ElevatedButton(
                  onPressed: () async {
                    await AudioPlayerUtils.player.play();
                  },
                  child: Text("Resume"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*BlocBuilder<YoutubeMusicsBloc, YoutubeMusicsState>(
builder: (context, state) {
if (state.state == BlocActionStates.fetching) {
return const Center(
child: CircularProgressIndicator(),
);
}
if (state.state == BlocActionStates.fetchFailed) {
return Text(state.error ?? '');
}
if (state.state == BlocActionStates.fetchSuccessed) {
return Expanded(
child: ListView.builder(
itemCount: state.youtubeAudios.length,
itemBuilder: (context, index) {
AudioModel audioModel = state.youtubeAudios[index];
return ListTile(
onTap: () async {
await AudioPlayerUtils.player
    .setAudioSource(audioModel.audioSource!);
AudioPlayerUtils.player.play();
},
title: Text(
"${audioModel.title}",
style: TextStyle(color: Colors.white),
),
);
},
),
);
}
return const Text("Initial");
},
),*/

// AIzaSyDgt6T7NR2GcTIWRxgTARLV2H_PljbWSrM

/*getVideoData() async {
  late List<int> musicBytes = [];
  var player = AudioPlayer();
  var yt = YoutubeExplode();

  var result =
  await yt.videos.get("https://www.youtube.com/watch?v=wO9phV3oBe0");

  var videos = await yt.channels.getUploadsFromPage("UCMF1IZjfEUY2ybMaFQ1eKiA");



  // var playlist = await yt.playlists.get(channel.id);

  // print(channel.id);

  // var data = await yt.videos.streamsClient
  //     .getManifest("https://www.youtube.com/watch?v=wO9phV3oBe0");
  //
  // var infoStream = data.audioOnly.withHighestBitrate();
  //
  // var stream = yt.videos.streamsClient.get(infoStream);
  //
  // // stream.listen((audioBytes) async {
  // // });
  //
  // await for (final bytes in stream) {
  //   musicBytes.addAll(bytes);
  // }
  //
  // // Uint8List finalData = Uint8List.fromList(musicBytes);
  // //
  // // final byteData = finalData.buffer.asByteData();
  // //
  // // Audio.loadFromByteData(byteData).play();
  //
  // // print(musicBytes);
  //
  // await player.setAudioSource(MyCustomSource(musicBytes));
  // player.play();
  // player.pause();

  // String? filePath = await FileUtils.instance.getFilePath();
  //
  // print(filePath);
  // if (filePath != null) {
  //   var file = File("$filePath/${result.title}.mp3");
  //   file.create();
  //
  //   var fileStream = file.openWrite();
  //
  //   // Pipe all the content of the stream into the file.
  //   await stream.pipe(fileStream);
  //
  //   print(file.path);
  //
  //   // Close the file.
  //   await fileStream.flush();
  //   await fileStream.close();
  // }
}*/
