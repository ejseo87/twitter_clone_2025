import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';

import 'package:twitter_clone_2025/views/features/users/widgets/mentioned_thread_tile.dart';
import 'package:twitter_clone_2025/views/common/widgets/reaction_icon_row.dart';

class UserTreadTile extends StatelessWidget {
  final String postedTime;
  final String mention;
  final bool mentioned;
  final String mentionedAvatar;
  final String mentionedUsername;
  final String mentionedMention;
  final int mentionedReplies;
  const UserTreadTile({
    super.key,
    required this.postedTime,
    required this.mention,
    required this.mentionedAvatar,
    required this.mentionedUsername,
    required this.mentionedMention,
    required this.mentionedReplies,
    required this.mentioned,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          isThreeLine: true,
          leading: const CircleAvatar(
            radius: Sizes.size20,
            foregroundColor: Colors.amber,
            foregroundImage:
                NetworkImage("https://picsum.photos/id/81/200/300"),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("alice_liddell"),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    postedTime,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: Sizes.size14,
                    ),
                  ),
                  Gaps.h5,
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.ellipsis,
                      size: Sizes.size16,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          subtitle: Text(
            mention,
            style: const TextStyle(
              fontSize: Sizes.size14,
            ),
          ),
        ),
        mentioned
            ? Column(
                children: [
                  Container(
                    width: width - Sizes.size16,
                    padding: const EdgeInsets.only(
                      top: Sizes.size16,
                      bottom: Sizes.size16,
                      left: Sizes.size72,
                      right: Sizes.size16,
                    ),
                    child: MentionedThreadTile(
                      avatarUrl: mentionedAvatar,
                      username: mentionedUsername,
                      mention: mentionedMention,
                      replies: mentionedReplies,
                    ),
                  ),
                ],
              )
            : Container(),
        const Padding(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.size10,
            horizontal: Sizes.size72,
          ),
          child: ReactionIconRow(),
        ),
      ],
    );
  }
}
