import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/view_models/settings_vm.dart';

class NavTab extends ConsumerWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String text;
  final bool isSelected;
  final Function onTap;
  const NavTab({
    super.key,
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.selectedIcon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(settingsProvider).darkmode;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Colors.transparent,
              width: 0.1,
            ),
          ),
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.6,
            duration: const Duration(milliseconds: 300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: isDark ? Colors.white : Colors.black,
                  size: Sizes.size24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
