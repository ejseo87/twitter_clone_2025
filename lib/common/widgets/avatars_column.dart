import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/sizes.dart';
import 'package:twitter_clone_2025/features/home/views/widgets/post_title.dart';
import 'package:twitter_clone_2025/common/widgets/avatar_with_icon.dart';
import 'package:twitter_clone_2025/common/widgets/render_avatar_group.dart';

class AvatarsColumn extends StatelessWidget {
  const AvatarsColumn({
    super.key,
    required this.avatar,
    required this.username,
    required this.threadType,
    required this.replyAvatars,
    required this.replyUsernames,
    required this.replies,
  });

  final String avatar;
  final String username;
  final ThreadType threadType;
  final List<String> replyAvatars;
  final List<String> replyUsernames;
  final int replies;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AvatarWithIcon(
          url: avatar,
          text: username,
          radius: 25,
          icon: FontAwesomeIcons.plus,
        ),
        replies > 0
            ? Expanded(
                child: VerticalDivider(
                  width: Sizes.size10,
                  thickness: Sizes.size1,
                  color: Colors.grey.shade500,
                  indent: 10,
                ),
              )
            : Container(),
        /* 
        ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: threadType == ThreadType.image ||
                      threadType == ThreadType.video
                  ? MediaQuery.of(context).size.height * 0.25
                  : 55),
          child: VerticalDivider(
            width: Sizes.size10,
            thickness: Sizes.size1,
            color: Colors.grey.shade500,
            indent: 10,
          ),
        ), */
        replies > 0
            ? RenderAvatarGroup(
                avatars: replyAvatars,
                texts: replyUsernames,
                replies: replies,
              )
            : Container(),
      ],
    );
  }
}
