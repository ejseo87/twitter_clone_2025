import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/contants/sizes.dart';
import 'package:twitter_clone_2025/witgets/form_button.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({super.key});
  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  bool agreed = false;

  void _onNextTap() {
    if (agreed) {
      Navigator.pop(context, agreed);
    }
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
        leading: GestureDetector(
          onTap: _onNextTap,
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v48,
            Text(
              textAlign: TextAlign.start,
              "Customize your experience",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Gaps.v28,
            const Text(
              "Track where you see Twitter content across the web.",
              style: TextStyle(
                color: Colors.black,
                fontSize: Sizes.size16 + Sizes.size2,
                fontWeight: FontWeight.w900,
              ),
            ),
            Gaps.v14,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: const Text(
                      "Twitter uses this data to personalize your experiece. This web browsing history will never be stored with your name, email, or phone number."),
                ),
                Switch.adaptive(
                  activeColor: Colors.green,
                  inactiveTrackColor: Colors.grey,
                  value: agreed,
                  onChanged: (value) {
                    agreed = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            Gaps.v36,
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: "By signing up, you agree to our ",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: Sizes.size16,
                  height: 1.2,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "Terms",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const TextSpan(text: ", "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const TextSpan(text: ", and "),
                  TextSpan(
                    text: "Cookie Use",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const TextSpan(
                      text:
                          ". Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy. "),
                  TextSpan(
                    text: "Learn more",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: Sizes.size20,
          horizontal: Sizes.size40,
        ),
        child: GestureDetector(
          onTap: _onNextTap,
          child: FormButton(
            disabled: !agreed,
            text: "Next",
            buttonType: ButtonType.big,
          ),
        ),
        /* AnimatedContainer(
            duration: const Duration(microseconds: 500),
            alignment: Alignment.center,
            height: 60,
            decoration: BoxDecoration(
              color: agreed ? Colors.black : Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(microseconds: 500),
              style: TextStyle(
                color: agreed ? Colors.white : Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              child: const Text(
                "Next",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ), */
      ),
    );
  }
}
