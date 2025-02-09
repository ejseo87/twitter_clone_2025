import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/sizes.dart';
import 'package:twitter_clone_2025/features/main_navigation/widgets/render_avatar.dart';

class AvatarWithPlus extends StatelessWidget {
  final String url;
  final String text;
  final double radius;
  const AvatarWithPlus({
    super.key,
    required this.url,
    required this.text,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          RenderAvatar(
            radius: radius,
            url: url,
            text: text,
          ),
          Positioned(
            right: -5,
            bottom: -5,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: const FaIcon(
                FontAwesomeIcons.circlePlus,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
