import 'dart:math';

import 'package:faker/faker.dart' as faker;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/contants/sizes.dart';
import 'package:twitter_clone_2025/view_models/settings_vm.dart';
import 'package:twitter_clone_2025/views/common/widgets/avatar_with_icon.dart';

List<String> tabs = [
  "All",
  "Replies",
  "Mentions",
  "Veiws",
  "Followers",
  "Followings",
];

class ActivityScreen extends StatefulWidget {
  static String routeUrl = "/activity";
  static String routeName = "acitivity";
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final _fakeData = faker.Faker();
  final int itemCount = 10;
  List<String> items = [];
  bool _isFollowed = false;

  final List<String> images = [];
  final List<String> usernames = [];
  final List<String> sentences = [];
  final List<String> notifications = [];
  final List<String> labels = [
    "Mentioned you",
    "Startgin out my gardening club with thread",
    "Followed you",
    "Likes your mention",
    "Mentioned you",
    "Startgin out my gardening club with thread",
    "Likes your mention",
    "Likes your mention",
    "Mentioned you",
    "Startgin out my gardening club with thread",
  ];
  final List<IconData> icons = [
    FontAwesomeIcons.at,
    FontAwesomeIcons.arrowTurnUp,
    FontAwesomeIcons.solidCircleUser,
    FontAwesomeIcons.solidHeart,
    FontAwesomeIcons.at,
    FontAwesomeIcons.arrowTurnUp,
    FontAwesomeIcons.solidCircleUser,
    FontAwesomeIcons.solidHeart,
    FontAwesomeIcons.at,
    FontAwesomeIcons.arrowRotateLeft,
  ];

  @override
  void initState() {
    super.initState();
    items = List<String>.generate(itemCount, (i) => "Item ${i + 1}");
    for (var i = 0; i < itemCount; i++) {
      images.add(_fakeData.image.loremPicsum(random: Random().nextInt(100)));
      usernames.add(_fakeData.person.firstName());
      sentences.add(_fakeData.lorem.sentence());
      notifications.add("${Random().nextInt(10)}h");
    }
  }

  void _onDismissed(int index) {
    items.remove(items[index]);
    images.remove(images[index]);
    usernames.remove(usernames[index]);
    sentences.remove(sentences[index]);
    notifications.remove(notifications[index]);
    labels.remove(labels[index]);
    icons.remove(icons[index]);
    setState(() {});
  }

  void _onPressedFollowButton({
    required BuildContext context,
    required String username,
    required int index,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "You are now following $username",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: Sizes.size20,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text("Close"),
              onPressed: () {
                setState(() {
                  _isFollowed = true;
                  labels[index] = "Followed each other";
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<SettingsViewModel>().darkmode;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            "Activity",
            style: TextStyle(
              fontSize: Sizes.size24,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
            labelPadding: const EdgeInsets.symmetric(horizontal: 3),
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: Colors.transparent,
            indicatorWeight: 0,
            indicator: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(Sizes.size10),
              border: Border.all(color: Colors.grey.shade400),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: isDark ? Colors.grey.shade500 : Colors.black,
            tabs: [
              for (var tab in tabs)
                Container(
                  width: 100,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Sizes.size10),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Text(
                    tab,
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
          child: TabBarView(
            children: [
              ListView.separated(
                itemCount: items.length,
                separatorBuilder: (context, index) => Divider(
                  color: isDark ? Colors.white : Colors.black,
                  indent: 80,
                ),
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(items[index]),
                    onDismissed: (direction) => _onDismissed(index),
                    background: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                        left: Sizes.size10,
                      ),
                      color: Colors.green,
                      child: const FaIcon(
                        FontAwesomeIcons.checkDouble,
                        color: Colors.white,
                        size: Sizes.size32,
                      ),
                    ),
                    secondaryBackground: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(
                        right: Sizes.size10,
                      ),
                      color: Colors.red,
                      child: const FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.white,
                        size: Sizes.size32,
                      ),
                    ),
                    child: ListTile(
                      key: Key("$index"),
                      isThreeLine: true,
                      leading: AvatarWithIcon(
                        url: images[index],
                        text: usernames[index],
                        radius: 25,
                        icon: icons[index],
                      ),
                      title: Row(
                        children: [
                          Text(
                            usernames[index],
                            style: const TextStyle(
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Gaps.h5,
                          Opacity(
                            opacity: 0.87,
                            child: Text(
                              notifications[index],
                            ),
                          ),
                        ],
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          text: labels[index],
                          style: TextStyle(
                            fontSize: Sizes.size16,
                            color: Colors.grey.shade500,
                          ),
                          children: [
                            TextSpan(
                              text: "\n${sentences[index]}",
                              style: TextStyle(
                                fontSize: Sizes.size16,
                                color: isDark
                                    ? Colors.grey.shade200
                                    : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      trailing: labels[index] == "Followed you" &&
                              _isFollowed == false
                          ? TextButton(
                              onPressed: () => _onPressedFollowButton(
                                  context: context,
                                  username: usernames[index],
                                  index: index),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size5,
                                  vertical: Sizes.size3,
                                ),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "Following",
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ),
                  );
                },
              ),
              for (var tab in tabs.skip(1))
                Center(
                  child: Text(
                    tab,
                    style: const TextStyle(
                      fontSize: Sizes.size28,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
