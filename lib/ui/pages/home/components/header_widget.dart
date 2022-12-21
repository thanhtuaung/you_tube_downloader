import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:you_tube_downloader/ui/src/extensions/context_extension.dart';

import '../../../src/constants.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 0.15,
      decoration: BoxDecoration(
          color: ConstantColors.primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
          child: Row(
            children: [
              Icon(
                Icons.headphones,
                size: 50,
                color: Colors.amber,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "YT Music",
                    style: GoogleFonts.alatsi(
                        color: Colors.amber,
                        fontSize: context.textTheme.headline5?.fontSize),
                  ),
                  Text(
                    "Enjoy your life with musics!",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
