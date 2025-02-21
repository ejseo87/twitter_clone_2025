import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';

class ReactionIconRow extends StatelessWidget {
  const ReactionIconRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Opacity(
        opacity: 0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FaIcon(
              FontAwesomeIcons.heart,
              size: Sizes.size20,
            ),
            Gaps.h24,
            FaIcon(
              FontAwesomeIcons.message,
              size: Sizes.size20,
            ),
            Gaps.h24,
            FaIcon(
              FontAwesomeIcons.arrowsRotate,
              size: Sizes.size20,
            ),
            Gaps.h24,
            FaIcon(
              FontAwesomeIcons.paperPlane,
              size: Sizes.size20,
            ),
          ],
        ),
      ),
    );
  }
}
