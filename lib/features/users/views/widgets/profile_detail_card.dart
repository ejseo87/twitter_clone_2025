import 'package:flutter/material.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/contants/sizes.dart';

class ProfileDetailCard extends StatelessWidget {
  final String numberString;
  final String numberLabel;
  const ProfileDetailCard({
    super.key,
    required this.numberString,
    required this.numberLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          numberString,
          style: const TextStyle(
            color: Colors.black,
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gaps.v3,
        Text(
          numberLabel,
          style: TextStyle(color: Colors.grey.shade500, fontSize: Sizes.size14),
        ),
      ],
    );
  }
}
