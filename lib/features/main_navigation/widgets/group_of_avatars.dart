import 'dart:math';

import 'package:flutter/material.dart';
import 'package:twitter_clone_2025/features/main_navigation/widgets/render_avatar.dart';

class GroupOfAvatars extends StatelessWidget {
  final int numOfAvatars;
  GroupOfAvatars({
    super.key,
    required this.numOfAvatars,
  });

  final int random1 = Random().nextInt(100);
  final int random2 = Random().nextInt(100);
  final int random3 = Random().nextInt(100);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 25,
      child: SizedBox(
        child: Stack(
          children: [
            numOfAvatars > 0
                ? Positioned(
                    top: 8,
                    right: 5,
                    child: RenderAvatar(radius: 12),
                  )
                : Container(),
            numOfAvatars > 1
                ? Positioned(
                    bottom: 12,
                    left: 5,
                    child: RenderAvatar(radius: 10),
                  )
                : Container(),
            numOfAvatars > 2
                ? Positioned(
                    bottom: 2,
                    right: 17,
                    child: RenderAvatar(radius: 7),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
