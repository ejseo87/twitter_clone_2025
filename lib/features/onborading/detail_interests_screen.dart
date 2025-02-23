import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/features/onborading/tutorial_screen.dart';
import 'package:twitter_clone_2025/features/onborading/widgets/selectable_button.dart';
import 'package:twitter_clone_2025/common/widgets/form_button.dart';

const detailInterests = [
  [
    // Fashion & beauty
    "makeup",
    "cosmetics",
    "plus size",
    "vintage",
    "skin care",
    "stree style",
    "80s fashion",
    "fashion designer",
    "90s fashion",
    "luxury bag",
    "luxury goods",
    "hair shops",
  ],
  [
    // outdoors
    "camping",
    "hiking",
    "foundation",
    "biking",
    "garden",
    "survival",
    "backpacking",
    "fishing",
    "babecuing",
    "mountain",
    "national park",
    "farming",
    "playground",
  ],
  [
    //Arts & culture
    "musical",
    "movies",
    "concerts",
    "gallery",
    "pop art",
    "wall art",
    "pop song",
    "musium",
    "abstarct art",
    "opera",
    "theater",
    "classical",
  ],
  [
    //Animation & comics
    "disney's",
    "comics",
    "japanese anime",
    "american animation",
    "canadian animation",
    "star wars series",
    "spiderman serires",
    "batman series",
    "robot series",
  ],
  [
    //Business & finance
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
  ],
  [
    // food
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
  ],
  [
    // travel
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
  ],
  [
    //entertainment
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
    "cosplay",
    "fanfiction",
  ],
  [
    //music
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
    "mp3 download",
    "piano",
  ],
  [
    //gaming
    "online gaming",
    "board games",
    "pc gameing",
    "car games",
    "league of legends",
    "video games",
    "racing games",
    "new games",
    "games for girls",
    "action games",
    "puzzle games",
    "kids games",
  ],
  [
    //animals
    "pets",
    "wild animals",
    "african animals",
    "dog food",
    "cat food",
    "emergency vet near me",
    "pet hotel",
    "wild animal park",
    "safari sites"
  ],
  [
    //drama
    "best k-drama",
    "squid game",
    "a game of thrones",
    "crash landing on you",
    "itaewon class",
    "extraordinary you",
    "descendants of the sun",
    "reply 1988",
    "kingdom",
    "netflix ranking",
    "apple ranking",
    "amazon ranking",
  ],
  [
    //learning
    "best shool",
    "top universities",
    "education portal",
    "deep learning",
    "Ai learning",
    "online education",
    "homeschooling",
    "aborad scholarship",
    "education channels",
    "educational games",
    "books for kids",
    "reading skills",
  ],
  [
    //sports
    "baseball scores",
    "extrem sports",
    "swimming",
    "golf",
    "tennis",
    "surfing",
    "runner",
    "basketball",
    "scuba diving",
    "skiing",
    "bowling",
    "football",
  ],
];

class DetailInterestsScreen extends StatefulWidget {
  final List<String> interests;
  final List<String> selectedInterests;
  const DetailInterestsScreen({
    super.key,
    required this.selectedInterests,
    required this.interests,
  });

  @override
  State<DetailInterestsScreen> createState() => _DetailInterestsScreenState();
}

class _DetailInterestsScreenState extends State<DetailInterestsScreen> {
  final List<int> selectedIndexs = [];
  late List<List<String>> currentSelections = [];

  @override
  void initState() {
    super.initState();
    var length = widget.selectedInterests.length;
    for (var i = 0; i < length; i++) {
      var index = widget.interests.indexOf(widget.selectedInterests[i]);
      selectedIndexs.add(index);
      List<String> newList = List<String>.empty(growable: true);
      currentSelections.add(newList);
    }

    print(selectedIndexs);
    print(currentSelections);
  }

  void checkSelected({
    required int index,
    required List<String> detailInterests,
    required List<String> detailSelection,
  }) {
    if (detailSelection.contains(detailInterests[index])) {
      detailSelection.remove(detailInterests[index]);
    } else {
      detailSelection.add(detailInterests[index]);
    }
    setState(() {});
    print("[end of checkSelected : detailSelection = $detailSelection");
  }

  bool _checkValidation() {
    var result = false;
    for (var i = 0; i < currentSelections.length; i++) {
      if (currentSelections[i].length >= 3) {
        result = true;
      } else {
        result = false;
      }
    }
    print("in _checkValidation function : result = $result");
    return result;
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
              for (var i = 0; i < selectedIndexs.length; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v32,
                    Text(
                      widget.interests[selectedIndexs[i]],
                      style: const TextStyle(
                        fontSize: Sizes.size20,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    Gaps.v20,
                    makeListView(
                      context: context,
                      detailInterests: detailInterests[selectedIndexs[i]],
                      detailSelected: currentSelections[i],
                    ),
                  ],
                )
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
                  disabled: _checkValidation() ? false : true,
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

  SingleChildScrollView makeListView({
    required BuildContext context,
    required List<String> detailInterests,
    required List<String> detailSelected,
  }) {
    //var itemCount = detailInterests.length ~/ 3;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.2,
          maxWidth: MediaQuery.of(context).size.width * 1.3,
        ),
        child: Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.end,
          alignment: WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          verticalDirection: VerticalDirection.down,
          children: [
            for (var index = 0; index < detailInterests.length; index++)
              FittedBox(
                child: SelectableButton(
                  buttonType: SelectableBtnType.oval,
                  title: detailInterests[index],
                  onTap: () => checkSelected(
                    index: index,
                    detailInterests: detailInterests,
                    detailSelection: detailSelected,
                  ),
                  selected: detailSelected.contains(detailInterests[index]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


/*



  SizedBox makeListView({
    required BuildContext context,
    required List<String> detailInterests,
    required List<String> detailSelected,
  }) {
    var itemCount = detailInterests.length ~/ 3;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableButton(
                title: detailInterests[itemCount * 0 + index],
                onTap: () => checkSelected(
                  index: itemCount * 0 + index,
                  detailInterests: detailInterests,
                  detailSelection: detailSelected,
                ),
                selected: detailSelected
                    .contains(detailInterests[itemCount * 0 + index]),
              ),
              SelectableButton(
                title: detailInterests[itemCount * 1 + index],
                onTap: () => checkSelected(
                  index: itemCount * 1 + index,
                  detailInterests: detailInterests,
                  detailSelection: detailSelected,
                ),
                selected: detailSelected
                    .contains(detailInterests[itemCount * 1 + index]),
              ),
              SelectableButton(
                title: detailInterests[itemCount * 2 + index],
                onTap: () => checkSelected(
                  index: itemCount * 2 + index,
                  detailInterests: detailInterests,
                  detailSelection: detailSelected,
                ),
                selected: detailSelected
                    .contains(detailInterests[itemCount * 2 + index]),
              ),
            ],
          );
        },
      ),
    );
  }
}


 */