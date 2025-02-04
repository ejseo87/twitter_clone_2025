import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/features/main_navigation/widgets/post_title.dart';
import 'package:twitter_clone_2025/features/main_navigation/widgets/render_floating_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  bool _showFloatingButton = false;
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
  }

  void _onTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              const SliverAppBar(
                title: FaIcon(
                  FontAwesomeIcons.at,
                  color: Colors.black,
                ),
                floating: true,
              ),
              SliverList.separated(
                itemCount: 10,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size20,
                    vertical: Sizes.size24,
                  ),
                  child: PostTile(
                    isIdentified: index % 6 == 0 ? true : false,
                    isVideo: index % 6 == 0 ? true : false,
                    isImage: index % 6 == 1 || index % 6 == 4 ? true : false,
                    numOfImages: index % 6 == 4 ? 3 : 1,
                  ),
                ),
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
                    child: const RenderFloatingButton(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
