import 'package:flutter/material.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size10,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: const TabBar(
        //labelColor: Colors.black,
        //indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Text(
            "Threads",
            style: TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Replies",
            style: TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 41.5;

  @override
  double get minExtent => 41.5;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
