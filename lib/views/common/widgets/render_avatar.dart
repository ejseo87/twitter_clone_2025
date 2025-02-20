import 'package:flutter/material.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';

class RenderAvatar extends StatelessWidget {
  final double radius;
  final String url;
  final String text;
  const RenderAvatar({
    super.key,
    required this.radius,
    required this.url,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).primaryColor,
      foregroundImage: NetworkImage(url),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: Sizes.size14,
          color: Colors.white,
        ),
      ),
    );
  }
}
