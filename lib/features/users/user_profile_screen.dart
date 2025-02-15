import 'dart:math';

import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/contants/sizes.dart';
import 'package:twitter_clone_2025/features/settings/settings_screen.dart';
import 'package:twitter_clone_2025/features/users/widgets/followers_avatar.dart';
import 'package:twitter_clone_2025/features/users/widgets/persistent_tab_bar.dart';
import 'package:twitter_clone_2025/features/users/widgets/user_thread_tile.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final List<String> _listOfAvtars = [
    "https://picsum.photos/id/60/200/300",
    "https://picsum.photos/id/83/200/300",
  ];
  final _itemCount = 10;
  final _fakeData = faker.Faker();
  final List<String> _mention = [];
  final List<String> _postedTime = [];
  final List<String> _mentionedAvatar = [];
  final List<String> _mentionedUsername = [];
  final List<String> _mentionedMention = [];
  final List<int> _mentionedReplies = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _itemCount; i++) {
      _mention.add(_fakeData.lorem.sentence());
      _postedTime.add("${Random().nextInt(12)}h");
      _mentionedAvatar
          .add(_fakeData.image.loremPicsum(random: Random().nextInt(300)));
      _mentionedUsername.add(_fakeData.person.lastName());
      _mentionedMention.add(_fakeData.lorem.sentences(5).join());
      _mentionedReplies.add(Random().nextInt(500));
    }
  }

  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              leading: IconButton(
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.globe,
                  color: Colors.grey.shade700,
                  size: Sizes.size20,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.camera,
                    color: Colors.grey.shade700,
                    size: Sizes.size20,
                  ),
                ),
                IconButton(
                  onPressed: _onGearPressed,
                  icon: FaIcon(
                    FontAwesomeIcons.gear,
                    color: Colors.grey.shade700,
                    size: Sizes.size20,
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      "Alice",
                      style: TextStyle(
                        fontSize: Sizes.size24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        const Text(
                          "alice_liddell",
                          style: TextStyle(
                            fontSize: Sizes.size14,
                            color: Colors.black,
                          ),
                        ),
                        Gaps.h5,
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size5,
                            horizontal: Sizes.size10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Sizes.size10),
                            color: Colors.grey.shade200,
                          ),
                          child: Text(
                            "thread.net",
                            style: TextStyle(
                              fontSize: Sizes.size12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: const CircleAvatar(
                      radius: 28,
                      foregroundColor: Colors.amber,
                      foregroundImage:
                          NetworkImage("https://picsum.photos/id/81/200/300"),
                    ),
                  ),
                  Gaps.v10,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
                    child: Text(
                      "It’s no use going back to yesterday, because I was a different person then.",
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Gaps.v20,
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.size16),
                    child: FollowersAvatar(avatars: _listOfAvtars),
                  ),
                  Gaps.v20,
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.size16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: Sizes.size5,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Sizes.size8),
                              border: Border.all(
                                color: Colors.grey.shade500,
                                width: 0.5,
                              ),
                            ),
                            child: const Text(
                              "Edit Profile",
                              style: TextStyle(
                                fontSize: Sizes.size14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Gaps.h10,
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: Sizes.size5,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Sizes.size8),
                              border: Border.all(
                                color: Colors.grey.shade500,
                                width: 0.5,
                              ),
                            ),
                            child: const Text(
                              "Share Profile",
                              style: TextStyle(
                                fontSize: Sizes.size14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v20,
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: PersistentTabBar(),
            ),
          ],
          body: TabBarView(
            children: [
              ListView.separated(
                itemBuilder: (context, index) => UserTreadTile(
                  postedTime: _postedTime[index],
                  mention: _mention[index],
                  mentionedAvatar: _mentionedAvatar[index],
                  mentionedUsername: _mentionedUsername[index],
                  mentionedMention: _mentionedMention[index],
                  mentionedReplies: _mentionedReplies[index],
                  mentioned: index % 2 == 1,
                ),
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey.shade300,
                ),
                itemCount: _itemCount,
              ),
              ListView.separated(
                itemBuilder: (context, index) => UserTreadTile(
                  postedTime: _postedTime[index],
                  mention: _mention[index],
                  mentionedAvatar: _mentionedAvatar[index],
                  mentionedUsername: _mentionedUsername[index],
                  mentionedMention: _mentionedMention[index],
                  mentionedReplies: _mentionedReplies[index],
                  mentioned: index % 2 == 1,
                ),
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey.shade300,
                ),
                itemCount: _itemCount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
