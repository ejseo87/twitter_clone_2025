import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';

class MentionedThreadTile extends StatelessWidget {
  final String avatarUrl;
  final String username;
  final String mention;
  final int replies;
  const MentionedThreadTile({
    super.key,
    required this.avatarUrl,
    required this.username,
    required this.mention,
    required this.replies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: Sizes.size12,
              foregroundColor: Colors.amber,
              foregroundImage: NetworkImage(avatarUrl),
            ),
            Gaps.h10,
            Text(
              username,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            Gaps.h5,
            const FaIcon(
              FontAwesomeIcons.circleCheck,
              size: Sizes.size14,
              color: Colors.blue,
            ),
          ],
        ),
        Gaps.v10,
        Text(
          textAlign: TextAlign.justify,
          softWrap: true,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          mention,
          style: const TextStyle(
            fontSize: Sizes.size14,
            color: Colors.black,
          ),
        ),
        Gaps.v16,
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            'https://picsum.photos/id/${Random().nextInt(300)}/300/200',
            fit: BoxFit.cover,
            alignment: Alignment.centerLeft,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
        Gaps.v16,
        Text(
          "$replies replies",
          style: TextStyle(
            fontSize: Sizes.size14,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
