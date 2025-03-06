import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/breakpoints.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/features/authentication/repos/authentication_repository.dart';
import 'package:twitter_clone_2025/features/write/models/thread_model.dart';
import 'package:twitter_clone_2025/features/write/views/widgets/action_sheet.dart';
import 'package:twitter_clone_2025/common/widgets/avatars_column.dart';
import 'package:twitter_clone_2025/common/widgets/reaction_icon_row.dart';
import 'package:twitter_clone_2025/utils.dart';

enum ThreadType { image, video, mention }

class PostTile extends ConsumerWidget {
  final ThreadModel threadData;
  final bool isIdentified;
  const PostTile({
    super.key,
    required this.threadData,
    required this.isIdentified,
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
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final userId = ref.read(authRepo).user!.uid;
    print("threadData.imageUrls.length = ${threadData.imageUrls!.length}");
    print(
        "!kIsWeb(${!kIsWeb}) && threadData.imageUrls!.isNotEmpty != [](${threadData.imageUrls!.isNotEmpty}) = ${!kIsWeb && threadData.imageUrls!.isNotEmpty}");
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        //mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: AvatarsColumn(
              avatar:
                  "https://firebasestorage.googleapis.com/v0/b/thread-ejseo-2025.firebasestorage.app/o/avatars%2F$userId?alt=media&haha=${DateTime.now().toString()}",
              username: threadData.creator,
              threadType: threadData.imageUrls!.isEmpty
                  ? ThreadType.mention
                  : ThreadType.image,
              replyAvatars: const [],
              replyUsernames: const [],
              replies: threadData.replies,
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
                            threadData.creator,
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
                              makeDateTimeDifference(threadData.createAt),
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
                  threadData.body,
                  textAlign: TextAlign.start,
                  maxLines:
                      !kIsWeb && threadData.imageUrls!.isNotEmpty ? 1 : null,
                  //maxLines: !false (true)&& false => false? 1 : null,
                  overflow: !kIsWeb && threadData.imageUrls!.isNotEmpty
                      ? TextOverflow.ellipsis
                      : TextOverflow.visible,
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                  ),
                ),
                Gaps.v8,
                threadData.imageUrls!.isNotEmpty
                    ? SizedBox(
                        height: 200,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: threadData.imageUrls!.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            width: Sizes.size8,
                          ),
                          itemBuilder: (BuildContext context, int index) =>
                              ClipRRect(
                            borderRadius: BorderRadius.circular(Sizes.size10),
                            child: Image.network(
                              threadData.imageUrls![index],
                              fit: BoxFit.cover,
                              alignment: Alignment.centerLeft,
                              height: width > Breakpoints.md ? 400 : 200,
                              width: width > Breakpoints.md ? 600 : 300,
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
                    '${threadData.replies} replies • ${threadData.likes} likes',
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

                /* 
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          threadData.imageUrl,
                          fit: BoxFit.cover,
                          alignment: Alignment.centerLeft,
                          height: width > Breakpoints.md ? 400 : 200,
                          width: width > Breakpoints.md ? 600 : 300,
                          loadingBuilder: (context, child, loadingProgress) {
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
                   */