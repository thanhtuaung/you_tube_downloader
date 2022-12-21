import 'package:flutter/material.dart';

import '../../../src/constants.dart';

class DescriptionRow extends StatelessWidget {
  const DescriptionRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Music Channels",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            "See More",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: ConstantColors.primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
