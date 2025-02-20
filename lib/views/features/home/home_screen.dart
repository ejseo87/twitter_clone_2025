import 'dart:math';

import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/views/features/home/widgets/post_title.dart';
import 'package:twitter_clone_2025/views/features/home/widgets/render_floating_button.dart';

class HomeScreen extends StatefulWidget {
  static String routeUrl = "/";
  static String routeName = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  bool _showFloatingButton = false;

  final int _itemCount = 10;
  final _fakeData = faker.Faker();
  final List<String> _avatars = [];
  final List<String> _mentions = [];
  final List<String> _usernames = [];
  final List<int> _replies = [];
  final List<int> _likes = [];
  final List<int> _postedTime = [];
  final List<String> _images = [];
  final List<String> _replyAvatars = [];
  final List<String> _replyUsernames = [];
  final List<String> _youtubeIds = [
    // "ThGbP9wgkz8",
    //ANCV3uG1GBg",
    //7X-haM3KJRI",
    "Ol1iy_TFito",
    "RU9AHzyzD-M",
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 900 && _showFloatingButton != true) {
        setState(
          () {
            _showFloatingButton = true;
          },
        );
      } else if (_scrollController.offset < 900 &&
          _showFloatingButton == true) {
        setState(() {
          _showFloatingButton = false;
        });
      }

      //print('CustomScrollView offset = ${_scrollController.offset}');
    });

    for (var i = 0; i < _itemCount; i++) {
      _avatars.add("https://picsum.photos/id/${Random().nextInt(400)}/200/300");
      _usernames.add(_fakeData.person.firstName());
      _mentions.add(_fakeData.lorem.sentences(3).toString());
      _replies.add(Random().nextInt(100) + 5);
      _likes.add(Random().nextInt(1000) + 15);
      _postedTime.add(Random().nextInt(5000) + 15);
      _images.add("https://picsum.photos/id/${Random().nextInt(400)}/300/200");
    }
    for (var j = 0; j < 3; j++) {
      _replyAvatars.add(_avatars[j]);
      _replyUsernames.add(_usernames[j]);
    }
  } //initState()

  void _onTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                const SliverAppBar(
                  title: FaIcon(
                    FontAwesomeIcons.at,
                  ),
                  floating: true,
                ),
                SliverList.separated(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    final modIndex = index % 5;
                    List<String> urls = [];
                    switch (modIndex) {
                      case 0:
                        //urls.add(_youtubeIds[index % 2]);
                        urls.add(_images[index]);
                        break;
                      case 1:
                        urls.add(_images[index]);
                        break;
                      case 3:
                        urls.add(_images[index]);
                        urls.add(_images[index % 2]);
                        urls.add(_images[index % 3]);
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size20,
                        vertical: Sizes.size24,
                      ),
                      child: PostTile(
                        isIdentified: modIndex == 0 ? true : false,
                        threadType: modIndex == 0
                            ? ThreadType.image
                            : modIndex == 1
                                ? ThreadType.image
                                : modIndex == 2
                                    ? ThreadType.mention
                                    : modIndex == 3
                                        ? ThreadType.image
                                        : ThreadType.mention,
                        numOfImages: modIndex == 3 ? 3 : 1,
                        avatar: _avatars[index],
                        username: _usernames[index],
                        mention: _mentions[index],
                        replies: _replies[index],
                        likes: _likes[index],
                        urls: urls,
                        replyAvatars: _replyAvatars,
                        replyUsernames: _replyUsernames,
                        postedTime: _postedTime[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Container(
                    height: Sizes.size1,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            _showFloatingButton
                ? Positioned(
                    top: 80,
                    left: MediaQuery.of(context).size.width * 0.5 - 138 / 2,
                    child: GestureDetector(
                      onTap: _onTop,
                      child: RenderFloatingButton(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
