import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:you_tube_downloader/ui/routes/route_list.dart';
import 'package:you_tube_downloader/ui/src/constants.dart';
import 'package:you_tube_downloader/ui/src/extensions/context_extension.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.headphones,
              size: 100,
              color: Colors.amber,
            ),
            Text(
              "YTMusic",
              style: GoogleFonts.aladin().copyWith(
                color: Colors.white,
                fontSize: Theme.of(context).textTheme.headline3?.fontSize,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Enjoy your life!",
              style: GoogleFonts.aBeeZee(
                color: Colors.amber,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  context.pushNamed(RouteList.homeScreen);
                },
                child: Text("Next")),
          ],
        ),
      ),
    );
  }
}
