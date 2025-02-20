import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone_2025/contants/sizes.dart';
import 'package:twitter_clone_2025/view_models/settings_vm.dart';

class FollowersAvatar extends StatelessWidget {
  final List<String> avatars;
  const FollowersAvatar({
    super.key,
    required this.avatars,
  });

  final double _radius = 10;
  final double _borderWidth = 3;

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<SettingsViewModel>().darkmode;
    return SizedBox(
      height: _radius + _borderWidth * 2,
      width: MediaQuery.of(context)
          .size
          .width, //_radius * (1 + avatars.length / 2) + 10,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (var i = 0; i < avatars.length; i++)
            Positioned(
              bottom: 0,
              left: _radius * 0.8 * avatars.length * i,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isDark ? Colors.grey.shade500 : Colors.white,
                    width: Sizes.size3,
                  ),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: _radius,
                  foregroundImage: NetworkImage(avatars[i]),
                  foregroundColor: Colors.blue,
                ),
              ),
            ),
          Positioned(
            bottom: 4,
            left: _radius * 0.8 * avatars.length + 32,
            child: Text(
              "${avatars.length} followers",
              style: const TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
