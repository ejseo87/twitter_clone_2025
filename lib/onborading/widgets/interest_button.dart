import 'package:flutter/material.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';

class InterestButton extends StatelessWidget {
  final bool isSelected;
  final String interest;

  const InterestButton({
    super.key,
    required this.interest,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    print('[InterestButton] isSelected = $isSelected, interest = $interest');
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Sizes.size24,
        vertical: Sizes.size16,
      ),
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(Sizes.size14),
        border: Border.all(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
      child: Text(
        textAlign: TextAlign.left,
        interest,
        style: TextStyle(
          fontSize: Sizes.size16,
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
