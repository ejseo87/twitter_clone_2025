import 'package:flutter/material.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';

enum SelectableBtnType { rectangle, oval }

class SelectableButton extends StatelessWidget {
  final SelectableBtnType buttonType;
  final String title;
  final VoidCallback onTap;
  final bool selected;
  const SelectableButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.selected,
    required this.buttonType,
  });

  @override
  Widget build(BuildContext context) {
    /* print(
        "[in SelectableInterestTile widget] title = $title,tselected=$selected"); */

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
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            child: Text(
              textAlign: buttonType == SelectableBtnType.oval
                  ? TextAlign.center
                  : TextAlign.start,
              title,
              style: TextStyle(
                fontSize: Sizes.size16,
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          (buttonType == SelectableBtnType.rectangle && selected)
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
