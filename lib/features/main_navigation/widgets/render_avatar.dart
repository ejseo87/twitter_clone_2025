import 'dart:math';
import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';

class RenderAvatar extends StatelessWidget {
  final double radius;
  RenderAvatar({
    super.key,
    required this.radius,
  });

  final random = Random().nextInt(300);
  final myFaker = faker.Faker();
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).primaryColor,
      foregroundImage: NetworkImage('https://picsum.photos/id/$random/100/100'),
      onForegroundImageError: (exception, stackTrace) =>
          NetworkImage('https://picsum.photos/id/${random + 1}/100/100'),
      child: Text(myFaker.person.firstName()),
    );
  }
}
