import 'dart:math';

import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/features/main_navigation/widgets/render_avatar.dart';

class RenderFloatingButton extends StatelessWidget {
  RenderFloatingButton({super.key});
  final double _gap = 3;
  final double _radius = 26;
  final _fakeData = faker.Faker();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 138,
      height: _radius + _gap * 6,
      padding: EdgeInsets.all(_gap * 2),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular((_radius + _gap * 4) / 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(left: 0, child: makeOneAvatar()),
          Positioned(left: _radius - (_gap * 3) / 2, child: makeOneAvatar()),
          Positioned(
              left: _radius * 2 - (_gap * 4) / 2, child: makeOneAvatar()),
          Positioned(
              left: _radius * 3 - (_gap * 4) / 2, child: makeOneAvatar()),
          Positioned(
            left: _radius * 4 - (_gap * 6) / 2,
            child: Container(
              width: _radius + 6,
              height: _radius + 6,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular((_radius + 4) / 2),
              ),
              child: const FaIcon(
                FontAwesomeIcons.circleArrowUp,
                size: 27,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container makeOneAvatar() {
    return Container(
      width: _radius + 6,
      height: _radius + 6,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular((_radius + 4) / 2),
      ),
      child: RenderAvatar(
        radius: _radius,
        url: _fakeData.image.loremPicsum(random: Random().nextInt(50)),
        text: _fakeData.person.firstName(),
      ),
    );
  }
}
