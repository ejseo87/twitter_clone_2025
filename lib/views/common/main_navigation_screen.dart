import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone_2025/views/common/widgets/nav_tab.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/views/features/activity/activity_screen.dart';
import 'package:twitter_clone_2025/views/features/home/home_screen.dart';
import 'package:twitter_clone_2025/views/features/write/widgets/write_sheet.dart';
import 'package:twitter_clone_2025/views/features/search/search_screen.dart';
import 'package:twitter_clone_2025/views/features/users/user_profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = "mainNavigattion";
  final String tab;
  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "",
    "search",
    "xxxx",
    "activity",
    "profile",
  ];
  late int _selectedIndex = max(_tabs.indexOf(widget.tab), 0);

  void _indexCheck() {
    if (_selectedIndex != _tabs.indexOf(widget.tab)) {
      _selectedIndex = max(_tabs.indexOf(widget.tab), 0);
      setState(() {});
    }
  }

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showWriteBottomSheet(BuildContext context, int index) async {
    /*    setState(() {
      _selectedIndex = index;
    }); */
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const WriteSheet(
        url: "https://picsum.photos/id/81/200/300",
        text: "alice_liddell",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _indexCheck();
    print(
        "_selectedIndex = $_selectedIndex, _tabs.indexOf(widget.tab) = ${_tabs.indexOf(widget.tab)}");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Offstage(
              offstage: _selectedIndex != 0,
              child: const HomeScreen() //HomeScreen(),
              ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const SearchScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const ActivityScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        //color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.size28,
            bottom: Sizes.size12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavTab(
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.houseUser,
                text: "Home",
                isSelected: _selectedIndex == 0,
                onTap: () => _onTap(0),
              ),
              NavTab(
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                text: "Discover",
                isSelected: _selectedIndex == 1,
                onTap: () => _onTap(1),
              ),
              NavTab(
                icon: FontAwesomeIcons.penToSquare,
                selectedIcon: FontAwesomeIcons.solidPenToSquare,
                text: "Inbox",
                isSelected: _selectedIndex == 2,
                onTap: () => _showWriteBottomSheet(context, 2),
              ),
              NavTab(
                icon: FontAwesomeIcons.heart,
                selectedIcon: FontAwesomeIcons.solidHeart,
                text: "Inbox",
                isSelected: _selectedIndex == 3,
                onTap: () => _onTap(3),
              ),
              NavTab(
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                text: "Profile",
                isSelected: _selectedIndex == 4,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
