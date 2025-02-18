import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/breakpoints.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/common/widgets/utils.dart';

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
    final isDark = isDartMode(context);
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(Sizes.size10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 0.5,
        ),
      ),
      child: Column(
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
            textAlign: TextAlign.start,
            softWrap: true,
            maxLines: kIsWeb ? null : 5,
            overflow: kIsWeb ? TextOverflow.visible : TextOverflow.ellipsis,
            mention,
            style: const TextStyle(
              fontSize: Sizes.size14,
            ),
          ),
          Gaps.v16,
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://picsum.photos/id/${Random().nextInt(300)}/300/200',
              fit: BoxFit.cover,
              alignment: Alignment.centerLeft,
              height: width > Breakpoints.md ? 400 : 200,
              width: width > Breakpoints.md ? 600 : 300,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const CircularProgressIndicator();
              },
              errorBuilder: (context, error, stackTrace) => Container(
                child: SizedBox(
                  height: width > Breakpoints.md ? 400 : 200,
                  width: width > Breakpoints.md ? 600 : 300,
                  child: const Center(
                    child: Text("Image Loading Fail..."),
                  ),
                ),
              ),
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
      ),
    );
  }
}
