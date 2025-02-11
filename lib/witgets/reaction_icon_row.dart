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
    return SizedBox(
      width: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FaIcon(
            FontAwesomeIcons.heart,
            size: Sizes.size20,
            color: Colors.grey.shade800,
          ),
          Gaps.h16,
          FaIcon(
            FontAwesomeIcons.message,
            size: Sizes.size20,
            color: Colors.grey.shade800,
          ),
          Gaps.h16,
          FaIcon(
            FontAwesomeIcons.arrowsRotate,
            size: Sizes.size20,
            color: Colors.grey.shade800,
          ),
          Gaps.h16,
          FaIcon(
            FontAwesomeIcons.paperPlane,
            size: Sizes.size20,
            color: Colors.grey.shade800,
          ),
        ],
      ),
    );
  }
}
