import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/features/home/view_models/timeline_view_models.dart';
import 'package:twitter_clone_2025/features/home/views/widgets/post_title.dart';
import 'package:twitter_clone_2025/features/home/views/widgets/render_floating_button.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static String routeUrl = "/home";
  static String routeName = "home";
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
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
  } //initState()

  void _onTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    print("HomeScreen : build()");
    return ref.watch(timelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              "Could not load threads : $error",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          data: (data) {
            print("HomeScreen :data: (data) : $data ");
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
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final threadData = data[index];
                            print(
                                "data[$index].replies = ${data[index].replies}");
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size20,
                                vertical: Sizes.size24,
                              ),
                              child: PostTile(
                                threadData: threadData,
                                isIdentified: true,
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
                            left: MediaQuery.of(context).size.width * 0.5 -
                                138 / 2,
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
          },
        );
  }
}
