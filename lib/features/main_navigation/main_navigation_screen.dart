import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/features/activity/activity_screen.dart';
import 'package:twitter_clone_2025/features/main_navigation/home_screen.dart';
import 'package:twitter_clone_2025/features/main_navigation/widgets/nav_tab.dart';
import 'package:twitter_clone_2025/features/main_navigation/widgets/stf_screen.dart';
import 'package:twitter_clone_2025/features/main_navigation/widgets/write_sheet.dart';
import 'package:twitter_clone_2025/features/search/search_screen.dart';
import 'package:twitter_clone_2025/features/users/user_profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 4;

  final _fakeData = faker.Faker();

  void _onTap(int index) {
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
      builder: (context) => WriteSheet(
        url: _fakeData.image.loremPicsum(),
        text: "jane_mobbin",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const HomeScreen(),
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
        color: Colors.white,
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
