import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/contants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final SvgPicture? icon;
  final bool isInverted;
  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.isInverted,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size14,
        ),
        decoration: BoxDecoration(
          color: isInverted ? Colors.black : Colors.white,
          border: Border.all(
            color: Colors.grey.shade400,
            width: Sizes.size2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isInverted
                ? Container()
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: Sizes.size28,
                      alignment: Alignment.center,
                      child: icon,
                    ),
                  ),
            Gaps.h10,
            Text(
              text,
              textAlign: TextAlign.center,
              style: isInverted
                  ? Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.white,
                      )
                  : Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
