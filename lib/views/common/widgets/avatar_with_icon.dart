import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/sizes.dart';
import 'package:twitter_clone_2025/views/common/widgets/render_avatar.dart';

class AvatarWithIcon extends StatelessWidget {
  final String url;
  final String text;
  final double radius;
  final IconData icon;
  const AvatarWithIcon({
    super.key,
    required this.url,
    required this.text,
    required this.radius,
    required this.icon,
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
              child: FaIcon(
                icon,
                color: icon == FontAwesomeIcons.plus
                    ? Colors.black
                    : icon == FontAwesomeIcons.solidHeart
                        ? Colors.pink
                        : icon == FontAwesomeIcons.solidCircleUser
                            ? Colors.purple
                            : icon == FontAwesomeIcons.at
                                ? Colors.green
                                : Colors.blue,
                size: Sizes.size20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
