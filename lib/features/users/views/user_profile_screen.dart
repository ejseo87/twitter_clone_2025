import 'dart:math';

import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/contants/sizes.dart';
import 'package:twitter_clone_2025/features/settings/view_models/settings_vm.dart';
import 'package:twitter_clone_2025/features/settings/views/settings_screen.dart';
import 'package:twitter_clone_2025/features/users/models/user_profile_model.dart';
import 'package:twitter_clone_2025/features/users/view_models/users_view_model.dart';
import 'package:twitter_clone_2025/features/users/views/widgets/followers_avatar.dart';
import 'package:twitter_clone_2025/features/users/views/widgets/persistent_tab_bar.dart';
import 'package:twitter_clone_2025/features/users/views/widgets/profile_avatar.dart';
import 'package:twitter_clone_2025/features/users/views/widgets/user_thread_tile.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  static String routeUrl = "/profile";
  static String routeName = "profile";

  const UserProfileScreen({super.key});

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  final List<String> _listOfAvtars = [
    "https://picsum.photos/id/60/200/300",
    "https://picsum.photos/id/83/200/300",
  ];
  final _itemCount = 5;
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
    /* Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    ); */
    context.pushNamed(SettingsScreen.routeName);
  }

  void _onEditProfilePressed(BuildContext context, UserProfileModel profile) {
//navigate to EditProfileScreen()
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(settingsProvider).darkmode;

    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) {
            return SafeArea(
              child: DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      backgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor,
                      elevation: 1,
                      leading: IconButton(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.globe,
                          size: Sizes.size20,
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.camera,
                            size: Sizes.size20,
                          ),
                        ),
                        IconButton(
                          onPressed: _onGearPressed,
                          icon: const FaIcon(
                            FontAwesomeIcons.gear,
                            size: Sizes.size20,
                          ),
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          ListTile(
                            isThreeLine: true,
                            tileColor:
                                Theme.of(context).appBarTheme.backgroundColor,
                            title: Text(
                              data.name,
                              style: const TextStyle(
                                fontSize: Sizes.size24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  data.email,
                                  style: const TextStyle(
                                    fontSize: Sizes.size14,
                                  ),
                                ),
                                Gaps.h5,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Sizes.size5,
                                    horizontal: Sizes.size10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(Sizes.size10),
                                    color: isDark
                                        ? Colors.grey.shade800
                                        : Colors.grey.shade200,
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
                            trailing: ProfileAvatar(
                              name: data.name,
                              hasAvatar: data.hasAvatar,
                              uid: data.uid,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                            padding: const EdgeInsets.only(
                              top: Sizes.size10,
                              bottom: Sizes.size20,
                              left: Sizes.size16,
                              right: Sizes.size16,
                            ),
                            child: Text(
                              data.intro,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: Sizes.size14,
                              ),
                            ),
                          ),
                          Container(
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size16,
                              vertical: Sizes.size20,
                            ),
                            child: FollowersAvatar(avatars: _listOfAvtars),
                          ),
                          Container(
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                            padding: const EdgeInsets.only(
                              left: Sizes.size16,
                              right: Sizes.size16,
                              top: Sizes.size10,
                              bottom: Sizes.size20,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: OutlinedButton(
                                    onPressed: () =>
                                        _onEditProfilePressed(context, data),
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: Colors.grey.shade500,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              Sizes.size8),
                                        )),
                                    child: const Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                        fontSize: Sizes.size14,
                                        fontWeight: FontWeight.bold,
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
                                      borderRadius:
                                          BorderRadius.circular(Sizes.size8),
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
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                      Container(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        child: ListView.separated(
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
                            color: Colors.grey.shade200,
                          ),
                          itemCount: _itemCount,
                        ),
                      ),
                      Container(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        child: ListView.separated(
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
                            color: isDark
                                ? Colors.grey.shade500
                                : Colors.grey.shade300,
                          ),
                          itemCount: _itemCount,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }
}
