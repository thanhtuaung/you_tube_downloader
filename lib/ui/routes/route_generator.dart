import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_tube_downloader/bloc/youtube_musics_bloc.dart';
import 'package:you_tube_downloader/ui/pages/home/home_screen.dart';
import 'package:you_tube_downloader/ui/pages/music_player_screen/music_player_screen.dart';
import 'package:you_tube_downloader/ui/pages/splash/splash_screen.dart';
import 'package:you_tube_downloader/ui/routes/route_list.dart';

Route<dynamic>? onGeneratorRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteList.splashScreen:
      return builder(settings, const SplashScreen());
    case RouteList.homeScreen:
      return builder(
          settings,
          BlocProvider(
            create: (context) => YoutubeMusicsBloc(),
            child: HomeScreen(),
          ));
    case RouteList.musicPlayerScreen:
      return builder(
          settings,
          BlocProvider(
            create: (context) => YoutubeMusicsBloc(),
            child: MusicPlayerScreen(),
          ));

    default:
      return builder(settings, NotFoundPage());
  }
}

Route<dynamic> builder(RouteSettings settings, Widget child) {
  return MaterialPageRoute(settings: settings, builder: (context) => child);
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
