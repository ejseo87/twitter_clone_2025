import 'dart:math';

import 'package:flutter/material.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';

class RenderImages extends StatelessWidget {
  final int number;
  RenderImages({
    super.key,
    required this.number,
  });

  final int postRandom = Random().nextInt(200);

  @override
  Widget build(BuildContext context) {
    print('number = $number');
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 200,
        width: 310 * number.toDouble(),
        child: ListView.separated(
          //shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: number,
          separatorBuilder: (context, index) => Gaps.h8,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://picsum.photos/id/${Random().nextInt(200)}/300/200',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const CircularProgressIndicator();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
