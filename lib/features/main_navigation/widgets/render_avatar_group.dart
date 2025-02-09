import 'dart:math';

import 'package:flutter/material.dart';
import 'package:twitter_clone_2025/witgets/render_avatar.dart';

class RenderAvatarGroup extends StatelessWidget {
  final List<String> avatars;
  final List<String> texts;
  final int replies;
  const RenderAvatarGroup({
    super.key,
    required this.avatars,
    required this.texts,
    required this.replies,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 25,
      child: SizedBox(
        child: Stack(
          children: [
            avatars.isNotEmpty
                ? Positioned(
                    top: 8,
                    right: 5,
                    child: RenderAvatar(
                      radius: 12,
                      url: avatars[0],
                      text: texts[0],
                    ),
                  )
                : Container(),
            avatars.length > 1
                ? Positioned(
                    bottom: 12,
                    left: 5,
                    child: RenderAvatar(
                      radius: 9,
                      url: avatars[1],
                      text: texts[1],
                    ),
                  )
                : Container(),
            avatars.length > 2
                ? Positioned(
                    bottom: 2,
                    right: 17,
                    child: RenderAvatar(
                      radius: 6,
                      url: avatars[2],
                      text: texts[2],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
