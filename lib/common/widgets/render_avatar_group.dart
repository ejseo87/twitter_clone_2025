import 'package:flutter/material.dart';
import 'package:twitter_clone_2025/common/widgets/render_avatar.dart';

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
            replies > 3
                ? const Positioned(
                    top: 8,
                    right: 5,
                    child: RenderAvatar(
                      radius: 12,
                      url: "",
                      text: "Anon",
                    ),
                  )
                : Container(),
            avatars.length > 1
                ? const Positioned(
                    bottom: 12,
                    left: 5,
                    child: RenderAvatar(
                      radius: 9,
                      url: "",
                      text: "Anon",
                    ),
                  )
                : Container(),
            avatars.length > 2
                ? const Positioned(
                    bottom: 2,
                    right: 17,
                    child: RenderAvatar(
                      radius: 6,
                      url: "",
                      text: "Anon",
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
