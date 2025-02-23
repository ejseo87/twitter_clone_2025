import 'package:flutter/material.dart';
import 'package:twitter_clone_2025/contants/sizes.dart';

class FormButton extends StatelessWidget {
  final bool disabled;
  final String text;

  const FormButton({
    super.key,
    required this.disabled,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        duration: const Duration(microseconds: 300),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size20,
        ),
        decoration: BoxDecoration(
          color: disabled ? Colors.grey.shade600 : const Color(0xFF0B64E0),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(microseconds: 300),
          style: TextStyle(
            color: disabled ? Colors.grey.shade400 : Colors.white,
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w600,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
