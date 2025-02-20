import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/breakpoints.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/views/features/home/widgets/render_images.dart';
import 'package:twitter_clone_2025/views/features/write/widgets/action_sheet.dart';
import 'package:twitter_clone_2025/views/common/widgets/avatars_column.dart';
import 'package:twitter_clone_2025/views/common/widgets/reaction_icon_row.dart';

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
    final width = MediaQuery.of(context).size.width;
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        //mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: AvatarsColumn(
              avatar: avatar,
              username: username,
              threadType: threadType,
              replyAvatars: replyAvatars,
              replyUsernames: replyUsernames,
              replies: replies,
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
                  maxLines: !kIsWeb && threadType == ThreadType.image ||
                          threadType == ThreadType.video
                      ? 1
                      : null,
                  overflow: !kIsWeb && threadType == ThreadType.image ||
                          threadType == ThreadType.video
                      ? TextOverflow.ellipsis
                      : TextOverflow.visible,
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                  ),
                ),
                Gaps.v8,
                threadType == ThreadType.image && urls!.length > 1
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
                              height: width > Breakpoints.md ? 400 : 200,
                              width: width > Breakpoints.md ? 600 : 300,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return const CircularProgressIndicator();
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                child: const SizedBox(
                                  width: 300,
                                  height: 200,
                                  child: Center(
                                    child: Text("Image Loading Fail..."),
                                  ),
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
      ),
    );
  }
}
