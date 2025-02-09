import 'dart:math';

import 'package:faker/faker.dart' as faker;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/witgets/avatar_with_icon.dart';
import 'package:twitter_clone_2025/features/main_navigation/widgets/render_avatar_group.dart';
import 'package:twitter_clone_2025/features/main_navigation/widgets/render_images.dart';
import 'package:twitter_clone_2025/features/main_navigation/widgets/action_sheet.dart';
import 'package:twitter_clone_2025/features/main_navigation/widgets/youtube_player.dart';

const List<String> youtubeIds = [
  "ThGbP9wgkz8",
  "ANCV3uG1GBg",
  "7X-haM3KJRI",
  "Ol1iy_TFito",
  "RU9AHzyzD-M",
];

class PostTile extends StatelessWidget {
  final bool isIdentified;
  final bool isVideo;
  final bool isImage;
  final int numOfImages;
  final int replies;
  final String url;
  final String text;
  final String sentence;
  PostTile({
    super.key,
    required this.isVideo,
    required this.isImage,
    required this.numOfImages,
    required this.isIdentified,
    required this.url,
    required this.text,
    required this.sentence,
    required this.replies,
  });

  final _fakeData = faker.Faker();

  final int viewRandom = Random().nextInt(300);
  //final int repliesRandom = Random().nextInt(15);
  final int likesRandom = Random().nextInt(100);

  void _onShowBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      //isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ActionSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> avatars = [];
    final List<String> texts = [];
    for (var i = 0; i < 3; i++) {
      avatars.add(_fakeData.image.loremPicsum(random: Random().nextInt(100)));
      texts.add(_fakeData.person.firstName());
    }
    print(avatars);
    print(texts);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AvatarWithIcon(
                    url: url,
                    text: text,
                    radius: 25,
                    icon: FontAwesomeIcons.plus,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: isImage || isVideo
                            ? MediaQuery.of(context).size.height * 0.25
                            : 55),
                    child: VerticalDivider(
                      width: Sizes.size10,
                      thickness: Sizes.size1,
                      color: Colors.grey.shade500,
                      indent: 10,
                    ),
                  ),
                ],
              ),
            ),
            Gaps.h10,
            Expanded(
              flex: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              text,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Gaps.h10,
                            isIdentified
                                ? FaIcon(
                                    FontAwesomeIcons.solidCircleCheck,
                                    color: Theme.of(context).primaryColor,
                                    size: Sizes.size14,
                                  )
                                : Container(),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              viewRandom >= 60
                                  ? "${viewRandom ~/ 60}h"
                                  : "${viewRandom}m",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: Sizes.size16,
                              ),
                            ),
                            Gaps.h10,
                            GestureDetector(
                              onTap: () => _onShowBottomSheet(context),
                              child: const FaIcon(
                                FontAwesomeIcons.ellipsis,
                                color: Colors.black,
                                size: Sizes.size20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gaps.v8,
                  Text(
                    sentence,
                    textAlign: TextAlign.start,
                    maxLines: isVideo || isImage ? 1 : null,
                    overflow: isVideo || isImage
                        ? TextOverflow.ellipsis
                        : TextOverflow.visible,
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                      color: Colors.black,
                    ),
                  ),
                  Gaps.v8,
                  isVideo
                      ? PostedVideoPlayer(
                          id: youtubeIds[Random().nextInt(5)],
                        )
                      : isImage && numOfImages > 1
                          ? RenderImages(
                              number: numOfImages,
                            )
                          : isImage && numOfImages == 1
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    'https://picsum.photos/id/${Random().nextInt(200)}/300/200',
                                    fit: BoxFit.cover,
                                    alignment: Alignment.centerLeft,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                )
                              : Container(),
                  Gaps.v10,
                  const Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.heart,
                      ),
                      Gaps.h16,
                      FaIcon(
                        FontAwesomeIcons.message,
                      ),
                      Gaps.h16,
                      FaIcon(
                        FontAwesomeIcons.arrowsRotate,
                      ),
                      Gaps.h16,
                      FaIcon(
                        FontAwesomeIcons.paperPlane,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: RenderAvatarGroup(
                avatars: avatars,
                texts: texts,
                replies: replies,
              ),
            ),
            Gaps.h10,
            Expanded(
              flex: 5,
              child: Text(
                '$replies replies • $likesRandom likes',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
