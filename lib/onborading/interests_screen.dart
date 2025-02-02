import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/onborading/detail_interests_screen.dart';
import 'package:twitter_clone_2025/onborading/widgets/selectable_button.dart';
import 'package:twitter_clone_2025/witgets/form_button.dart';

const interests = [
  "Fashion & beauty",
  "Outdoors",
  "Arts & culture",
  "Animation & comics",
  "Business & finance",
  "Food",
  "Travel",
  "Entertainment",
  "Music",
  "Gaming",
  "Animals",
  "Drama",
  "Learning",
  "Sports",
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final List<String> _selectedInterets = [];

  void checkSelected(int index) {
    if (_selectedInterets.contains(interests[index])) {
      _selectedInterets.remove(interests[index]);
    } else {
      _selectedInterets.add(interests[index]);
    }
    setState(() {});
    print("[end of checkSelected _selectedInterets = $_selectedInterets");
  }

  void _onNextTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailInterestsScreen(
            interests: interests,
            selectedInterests: _selectedInterets,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
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
              Gaps.v52,
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 2 / 1,
                children: [
                  for (var index = 0; index < interests.length; index++)
                    SelectableButton(
                      buttonType: SelectableBtnType.rectangle,
                      onTap: () => checkSelected(index),
                      title: interests[index],
                      selected: _selectedInterets.contains(interests[index]),
                    ),
                ],
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Greate work 🎉"),
              GestureDetector(
                onTap: _onNextTap,
                child: FormButton(
                  disabled: _selectedInterets.length >= 3 ? false : true,
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
