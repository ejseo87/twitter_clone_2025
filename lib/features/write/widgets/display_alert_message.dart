import 'package:flutter/material.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';

class DisplayAlertMessage extends StatelessWidget {
  final String alertMessage;
  const DisplayAlertMessage({
    super.key,
    required this.alertMessage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            alertMessage,
            style: const TextStyle(
              color: Colors.white,
              fontSize: Sizes.size20,
            ),
          ),
          Gaps.v20,
          const CircularProgressIndicator.adaptive(),
        ],
      ),
    );
  }
}
