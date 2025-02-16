import 'package:flutter/material.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/widgets/utils.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isDark = isDartMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size10,
      ),
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: const TabBar(
        //labelColor: Colors.black,
        //indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Sizes.size5,
            ),
            child: Text(
              "Threads",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Sizes.size5,
            ),
            child: Text(
              "Replies",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 51.5;

  @override
  double get minExtent => 51.5;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
