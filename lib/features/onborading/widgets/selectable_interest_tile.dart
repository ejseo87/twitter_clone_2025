import 'package:flutter/material.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';

class SelectableInterestTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool selected;
  const SelectableInterestTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
/*     print(
        "[in SelectableInterestTile widget] title = $title, \tselected=$selected"); */

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AnimatedContainer(
            alignment: Alignment.bottomLeft,
            duration: const Duration(microseconds: 300),
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: Sizes.size10,
              vertical: Sizes.size10,
            ),
            decoration: BoxDecoration(
              color: selected ? Theme.of(context).primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(Sizes.size14),
              border: Border.all(
                color: Colors.grey.shade400,
              ),
            ),
            child: Text(
              textAlign: TextAlign.left,
              title,
              style: TextStyle(
                fontSize: Sizes.size16,
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          selected
              ? const Positioned(
                  top: Sizes.size10,
                  right: Sizes.size10,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: Sizes.size20,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
