import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/features/settings/view_models/settings_vm.dart';
import 'package:twitter_clone_2025/features/write/view_models/upload_thread_view_model.dart';
import 'package:twitter_clone_2025/features/write/views/camera_screen.dart';
import 'package:twitter_clone_2025/common/widgets/render_avatar_group.dart';
import 'package:twitter_clone_2025/common/widgets/render_avatar.dart';

class WriteSheet extends ConsumerStatefulWidget {
  static const String routeUrl = "/write";
  static const String routeName = "write";
  final String url;
  final String text;

  const WriteSheet({
    super.key,
    required this.url,
    required this.text,
  });

  @override
  WriteSheetState createState() => WriteSheetState();
}

class WriteSheetState extends ConsumerState<WriteSheet> {
  final TextEditingController _textController = TextEditingController();

  //final bool _isAnyInput = false;
  //final bool _getImage = false;
  List<XFile>? _images;
  String _text = "";

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _text = _textController.text;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onTapHideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _onCancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onPost(BuildContext context) {
    print("_text = $_text");
    ref.read(uploadThreadProvider.notifier).uploadThread(
          context: context,
          text: _text,
          files: _images?.map((image) => File(image.path)).toList(),
        );
  }

  Future<void> _onCameraTap() async {
    final List<XFile>? images = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CameraScreen(),
      ),
    );
    if (images != null) {
      print("Xfile image = $images");
      _images = images;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(settingsProvider).darkmode;
    return Container(
      height: size.height * 0.9,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size12),
      ),
      child: GestureDetector(
        onTap: _onTapHideKeyboard,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
          appBar: AppBar(
            title: const Text(
              "New thread",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size18,
              ),
            ),
            centerTitle: true,
            leading: TextButton(
              onPressed: () => _onCancel(context),
              style: TextButton.styleFrom(
                overlayColor: Colors.blue,
              ),
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: Sizes.size14,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            leadingWidth: Sizes.size80,
            elevation: 1,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size10,
                    vertical: Sizes.size20,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              RenderAvatar(
                                radius: 25,
                                url: widget.url,
                                text: widget.text,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: VerticalDivider(
                                  width: 10,
                                  thickness: 1,
                                  color: Colors.grey.shade400,
                                  indent: Sizes.size10,
                                  endIndent: Sizes.size10,
                                ),
                              ),
                              Opacity(
                                opacity: 0.5,
                                child: RenderAvatarGroup(
                                    avatars: [widget.url],
                                    texts: [widget.text],
                                    replies: 1),
                              ),
                            ],
                          ),
                        ),
                        Gaps.h10,
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.text,
                                style: const TextStyle(
                                  //color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Gaps.v5,
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                child: TextField(
                                  controller: _textController,
                                  maxLines: null,
                                  minLines: null,
                                  textInputAction: TextInputAction.newline,
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: const InputDecoration(
                                    hintText: "Start a thread...",
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              Gaps.v10,
                              _images == null
                                  ? GestureDetector(
                                      onTap: _onCameraTap,
                                      child: FaIcon(
                                        FontAwesomeIcons.paperclip,
                                        color: isDark
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade600,
                                        size: Sizes.size20,
                                      ),
                                    )
                                  : Stack(
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: _images!.length,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                              width: Sizes.size8,
                                            ),
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Sizes.size10),
                                              child: Image.file(
                                                File(_images![index].path),
                                                fit: BoxFit.cover,
                                                width: 300,
                                                height: 200,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: Sizes.size10,
                                          right: Sizes.size10,
                                          child: IconButton(
                                            onPressed: () => setState(() {
                                              _images = null;
                                            }),
                                            icon: const FaIcon(
                                              FontAwesomeIcons.xmark,
                                              color: Colors.white,
                                              size: Sizes.size32,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  color: isDark ? Colors.grey.shade900 : Colors.white,
                  width: size.width,
                  padding: const EdgeInsets.only(
                    top: Sizes.size20,
                    bottom: Sizes.size40,
                    left: Sizes.size20,
                    right: Sizes.size20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        "Anyone can reply",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                        ),
                      ),
                      TextButton(
                        onPressed:
                            _text.isNotEmpty ? () => _onPost(context) : null,
                        child: const Text(
                          "Post",
                          style: TextStyle(
                            fontSize: Sizes.size20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
