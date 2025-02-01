import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/onborading/tutorial_screen.dart';
import 'package:twitter_clone_2025/onborading/widgets/interest_button.dart';
import 'package:twitter_clone_2025/onborading/widgets/selectable_button.dart';
import 'package:twitter_clone_2025/onborading/widgets/selectable_interest_tile.dart';
import 'package:twitter_clone_2025/witgets/form_button.dart';

const fashion = [
  "makeup",
  "cosmetics",
  "plus size clothing",
  "vintage clothing",
  "skin care products",
  "stree style store",
  "80s fashion",
  "fashion designer",
  "90s fashion",
];
const outdoors = [
  "camping",
  "hiking",
  "wild foundation",
  "biking",
  "garden",
  "survival",
  "backpacking",
  "fishig",
  "babecuing",
  "mountain",
  "national park",
  "farming",
  "playground",
];
const arts = [
  "musical",
  "movies",
  "concerts",
  "gallery",
  "pop art",
  "wall art",
  "pop song",
  "metropolitan museum of art",
  "abstarct art",
  "opera",
  "theater",
  "classical",
];
const animations = [
  "disney's",
  "comics",
  "japanese anime",
  "american animation",
  "canadian animation",
  "star wars series",
  "spiderman serires",
  "batman series",
  "robot series",
];
const business = [
  "usa stocks",
  "money management",
  "financial consultant",
  "bbc business",
  "loan for business",
  "online business",
  "financial news",
  "banks",
  "IMF",
  "World Bank",
  "startups",
  "tech biz.",
];
const food = [
  "air fryer recipes",
  "asian food",
  "food processors",
  "cookie recipes",
  "master chef",
  "bakery",
  "food service",
  "fast food",
  "beverage",
  "fruits",
  "vegitabls",
];
const travel = [
  "travel blog",
  "trave youtubers",
  "hotels",
  "flights",
  "airline tickets",
  "vacation packages",
  "travel agency",
  "luxury travel",
  "family travel",
  "trave vlog",
];
const entertainment = [
  "celebrity news",
  "netfix",
  "hulu",
  "amazon prime",
  "the intern",
  "new moives",
  "popular drama",
  "comedy shows",
  "quiz shows",
  "actors",
  "podcats",
  "cosplay",
  "fanfiction",
  "box office",
];
const music = [
  "new songs",
  "best songs",
  "spotify",
  "jazz",
  "mozart",
  "beethoven",
  "ukulele",
  "guitar",
  "youtube music",
  "apple music",
  "mp3 paw",
];
const gaming = [
  "online gaming",
  "board games",
  "pc gameing",
  "car games",
  "lol",
  "video games",
  "racing games",
  "new games",
  "games for girls",
  "action games",
  "puzzle games",
  "kids games",
  "best games",
];
const animals = [
  "pets",
  "wild animals",
  "african animals",
  "dog food",
  "cat food",
  "emergency vet near me",
  "pet hotel",
  "wild animal park",
  "safari sites"
];
const drama = [
  "best k-drama",
  "squid game",
  "crash landing on you",
  "itaewon class",
  "extraordinary you",
  "descendants of the sun",
  "reply 1988",
  "kingdom"
];
const learning = [
  "best shool",
  "top universities",
  "education portal",
  "deep learning",
  "Ai learning",
  "online education",
  "STEM",
  "homeschooling",
  "aborad scholarship",
  "education channels",
  "educational games",
  "books for kids",
  "reading skills",
];
const sports = [
  "baseball scores",
  "extrem sports",
  "swimming",
  "golf",
  "tennis",
  "surfing",
  "runner",
  "masketball",
  "scuba diving",
  "skiing",
  "bowling",
  "football",
];

class DetailInterestsScreen extends StatefulWidget {
  final selectedInterests;
  const DetailInterestsScreen({super.key, this.selectedInterests});

  @override
  State<DetailInterestsScreen> createState() => _DetailInterestsScreenState();
}

class _DetailInterestsScreenState extends State<DetailInterestsScreen> {
  final List<String> selection1 = [];
  final List<String> selection2 = [];
  final List<String> selection3 = [];

  List<List<String>> makeThreeSublists(List<String> list) {
    return List.generate(
      3,
      (index) {
        final start = index * 3;
        final end = (index + 1) * 3;
        return end > list.length
            ? list.sublist(start)
            : list.sublist(start, end);
      },
    );
  }

  void checkSelected({
    required int index,
    required List<String> interests,
    required List<String> selected,
  }) {
    if (selected.contains(interests[index])) {
      selected.remove(interests[index]);
    } else {
      selected.add(interests[index]);
    }
    setState(() {});
    print("[end of checkSelected selected = $selected");
  }

  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TutorialScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final partition1 = makeThreeSublists(outdoors);
    final partition2 = makeThreeSublists(food);
    final partition3 = makeThreeSublists(travel);
    print(widget.selectedInterests);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset(
          "assets/images/twitter-color-svgrepo-com.svg",
          width: 30,
          height: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.size16,
            bottom: Sizes.size24,
            left: Sizes.size24,
            right: Sizes.size24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Gaps.v14,
              const Text(
                "What do you want to see on Twitter?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1),
              ),
              Gaps.v20,
              const Text(
                "Select at least 3 interests to personalize your Twitter experience. They will be visible on your profile.",
                style: TextStyle(
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Gaps.v32,
              const Text(
                "Outdoors",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              Gaps.v20,
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    for (final partition in partition1)
                      SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: partition.length,
                          itemBuilder: (context, index) {
                            final interest = partition[index];
                            return SelectableButton(
                              title: interest,
                              onTap: () => checkSelected(
                                index: index,
                                interests: partition,
                                selected: selection1,
                              ),
                              selected: selection1.contains(interest),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
              Gaps.v32,
              const Text(
                "Food",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              Gaps.v20,
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    for (final partition in partition2)
                      SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: partition.length,
                          itemBuilder: (context, index) {
                            final interest = partition[index];
                            return SelectableButton(
                              title: interest,
                              onTap: () => checkSelected(
                                index: index,
                                interests: partition,
                                selected: selection2,
                              ),
                              selected: selection2.contains(interest),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
              Gaps.v32,
              const Text(
                "Travel",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              Gaps.v20,
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    for (final partition in partition3)
                      SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: partition.length,
                          itemBuilder: (context, index) {
                            final interest = partition[index];
                            return SelectableButton(
                              title: interest,
                              onTap: () => checkSelected(
                                index: index,
                                interests: partition,
                                selected: selection3,
                              ),
                              selected: selection3.contains(interest),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: Sizes.size32,
            top: Sizes.size16,
            left: Sizes.size24,
            right: Sizes.size24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: _onNextTap,
                child: FormButton(
                  disabled: (selection1.length >= 3) &&
                          (selection2.length >= 3) &&
                          (selection3.length >= 3)
                      ? false
                      : true,
                  text: "Next",
                  buttonType: ButtonType.small,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
