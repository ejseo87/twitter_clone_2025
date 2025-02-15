import 'dart:math';

import 'package:faker/faker.dart' as faker;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/widgets/render_avatar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _fakeData = faker.Faker();
  final List<String> images = [];
  final List<String> discriptions = [];
  final List<String> usernames = [];
  final List<String> followers = [];
  final int _itemCount = 20;

  final TextEditingController _textEditingController =
      TextEditingController(text: "Search");

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _itemCount; i++) {
      images.add(_fakeData.image.loremPicsum(random: Random().nextInt(300)));
      discriptions.add(_fakeData.person.name());
      usernames.add(_fakeData.person.firstName());
      followers.add(_fakeData.randomGenerator.fromPattern(["##.#K", "#.#K"]));
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onSearchChaned(String value) {
    print("in _onSearchChanged value = $value");
  }

  void _onSearchSubmitted(String value) {
    print("in _onSearchSubmitted value = $value");
    FocusScope.of(context).unfocus();
  }

  void _onBodyTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Search",
          style: TextStyle(
            fontSize: Sizes.size24,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size20,
              vertical: Sizes.size10,
            ),
            child: CupertinoSearchTextField(
              controller: _textEditingController,
              onChanged: _onSearchChaned,
              onSubmitted: _onSearchSubmitted,
              prefixIcon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: _onBodyTap,
        child: ListView.separated(
          itemCount: _itemCount,
          separatorBuilder: (context, index) => const Divider(
            color: Colors.black,
            indent: 80,
          ),
          itemBuilder: (context, index) => ListTile(
            isThreeLine: true,
            leading: RenderAvatar(
              radius: 25,
              url: images[index],
              text: usernames[index],
            ),
            title: Row(
              children: [
                Text(
                  usernames[index],
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Gaps.h5,
                SvgPicture.asset(
                  "assets/images/checkmark-seal-fill-svgrepo-com.svg",
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    Colors.lightBlue,
                    BlendMode.srcATop,
                  ),
                ),
              ],
            ),
            subtitle: RichText(
              text: TextSpan(
                text: discriptions[index],
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.grey.shade500,
                ),
                children: [
                  TextSpan(
                    text: "\n${followers[index]} followers",
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 2.0,
                    ),
                  )
                ],
              ),
            ),
            trailing: Container(
              height: Sizes.size36,
              width: Sizes.size96,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(Sizes.size10),
              ),
              child: const Text(
                "Follow",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
