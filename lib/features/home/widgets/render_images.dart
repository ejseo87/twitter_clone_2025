import 'dart:math';

import 'package:flutter/material.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';

class RenderImages extends StatelessWidget {
  final List<String> urls;
  RenderImages({
    super.key,
    required this.urls,
  });

  final int postRandom = Random().nextInt(200);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 200,
        width: 310 * urls.length.toDouble(),
        child: ListView.separated(
          //shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: urls.length,
          separatorBuilder: (context, index) => Gaps.h8,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                urls[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const CircularProgressIndicator();
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  child: const Center(
                    child: Text("Image Loading Fail...."),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
