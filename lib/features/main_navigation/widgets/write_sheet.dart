import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/features/main_navigation/camera_screen.dart';
import 'package:twitter_clone_2025/features/main_navigation/widgets/render_avatar_group.dart';
import 'package:twitter_clone_2025/widgets/render_avatar.dart';

class WriteSheet extends StatefulWidget {
  final String url;
  final String text;

  const WriteSheet({
    super.key,
    required this.url,
    required this.text,
  });

  @override
  State<WriteSheet> createState() => _WriteSheetState();
}

class _WriteSheetState extends State<WriteSheet> {
  bool _isAnyInput = false;
  final bool _getImage = false;
  XFile? _image;

  void _onTapHideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _onCancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onPost(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<void> _onCameraTap() async {
    final XFile image = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CameraScreen(),
      ),
    );
    print("Xfile image = $image");
    _image = image;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.9,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size12),
      ),
      child: GestureDetector(
        onTap: _onTapHideKeyboard,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontSize: Sizes.size14,
                  color: Colors.black,
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
                              height: MediaQuery.of(context).size.height * 0.1,
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
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.text,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Gaps.v5,
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.12,
                              child: TextField(
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      _isAnyInput = true;
                                    });
                                  } else {
                                    setState(() {
                                      _isAnyInput = false;
                                    });
                                  }
                                },
                                //expands: true,
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
                            _image == null
                                ? GestureDetector(
                                    onTap: _onCameraTap,
                                    child: FaIcon(
                                      FontAwesomeIcons.paperclip,
                                      color: Colors.grey.shade600,
                                      size: Sizes.size20,
                                    ),
                                  )
                                : Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          Sizes.size10,
                                        ),
                                        child: Image.file(
                                          File(_image!.path),
                                          fit: BoxFit.cover,
                                          width: 300,
                                          height: 200,
                                        ),
                                      ),
                                      Positioned(
                                        top: Sizes.size10,
                                        right: Sizes.size10,
                                        child: IconButton(
                                          onPressed: () => setState(() {
                                            _image = null;
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
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
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
                        onPressed: _isAnyInput ? () => _onPost(context) : null,
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
