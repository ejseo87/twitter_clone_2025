import 'package:flutter/material.dart';

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
      child: Text(text),
    );
  }
}
