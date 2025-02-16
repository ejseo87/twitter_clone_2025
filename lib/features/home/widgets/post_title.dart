import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/widgets/avatar_with_icon.dart';
import 'package:twitter_clone_2025/widgets/render_avatar_group.dart';
import 'package:twitter_clone_2025/features/home/widgets/render_images.dart';
import 'package:twitter_clone_2025/features/main_navigation/widgets/action_sheet.dart';
import 'package:twitter_clone_2025/features/home/widgets/youtube_player.dart';
import 'package:twitter_clone_2025/widgets/reaction_icon_row.dart';

enum ThreadType { image, video, mention }

class PostTile extends StatelessWidget {
  final bool isIdentified;
  final ThreadType threadType;
  final int numOfImages;
  final String avatar;
  final String username;
  final String mention;
  final int postedTime;
  final int replies;
  final int likes;
  final List<String>? urls;
  final List<String> replyAvatars;
  final List<String> replyUsernames;

  const PostTile({
    super.key,
    required this.isIdentified,
    required this.threadType,
    required this.numOfImages,
    required this.avatar,
    required this.username,
    required this.mention,
    required this.postedTime,
    required this.replies,
    required this.likes,
    required this.urls,
    required this.replyAvatars,
    required this.replyUsernames,
  });

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
    return Row(
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
                url: avatar,
                text: username,
                radius: 25,
                icon: FontAwesomeIcons.plus,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: threadType == ThreadType.image ||
                            threadType == ThreadType.video
                        ? MediaQuery.of(context).size.height * 0.25
                        : 55),
                child: VerticalDivider(
                  width: Sizes.size10,
                  thickness: Sizes.size1,
                  color: Colors.grey.shade500,
                  indent: 10,
                ),
              ),
              RenderAvatarGroup(
                avatars: replyAvatars,
                texts: replyUsernames,
                replies: replies,
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
                          username,
                          style: const TextStyle(
                            //color: Colors.black,
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
                        Opacity(
                          opacity: 0.7,
                          child: Text(
                            postedTime >= 1440
                                ? "${postedTime ~/ 1440}d"
                                : postedTime >= 60
                                    ? "${postedTime ~/ 60}h"
                                    : "${postedTime}m",
                            style: const TextStyle(
                              fontSize: Sizes.size16,
                            ),
                          ),
                        ),
                        Gaps.h10,
                        GestureDetector(
                          onTap: () => _onShowBottomSheet(context),
                          child: const FaIcon(
                            FontAwesomeIcons.ellipsis,
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
                mention,
                textAlign: TextAlign.start,
                maxLines: threadType == ThreadType.image ||
                        threadType == ThreadType.video
                    ? 1
                    : null,
                overflow: threadType == ThreadType.image ||
                        threadType == ThreadType.video
                    ? TextOverflow.ellipsis
                    : TextOverflow.visible,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
              Gaps.v8,
              threadType == ThreadType.video
                  ? PostedVideoPlayer(
                      id: urls![0],
                    )
                  : threadType == ThreadType.image && urls!.length > 1
                      ? RenderImages(
                          urls: urls!,
                        )
                      : threadType == ThreadType.image && urls!.length == 1
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                urls![0],
                                fit: BoxFit.cover,
                                alignment: Alignment.centerLeft,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return const CircularProgressIndicator();
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  child: const Center(
                                    child: Text("Image Loading Fail..."),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
              Gaps.v10,
              const ReactionIconRow(),
              Gaps.v20,
              Opacity(
                opacity: 0.7,
                child: Text(
                  '$replies replies • $likes likes',
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
