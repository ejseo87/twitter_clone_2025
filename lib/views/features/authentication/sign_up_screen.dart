import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/contants/sizes.dart';
import 'package:twitter_clone_2025/views/features/authentication/account_screen.dart';
import 'package:twitter_clone_2025/views/features/authentication/login_screen.dart';
import 'package:twitter_clone_2025/views/common/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  static const double _svgIconSize = 28;

  void _onAccoountTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AccountScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Hero(
          tag: "twitterLogo",
          child: SvgPicture.asset(
            "assets/images/twitter-color-svgrepo-com.svg",
            width: 30,
            height: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size40,
        ),
        child: Column(
          children: [
            Gaps.v96,
            Gaps.v48,
            Text(
              textAlign: TextAlign.center,
              "See what's happening in the world right now.",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Gaps.v96,
            Gaps.v64,
            AuthButton(
              icon: SvgPicture.asset(
                'assets/images/google-icon-logo-svgrepo-com.svg',
                width: _svgIconSize,
                height: _svgIconSize,
              ),
              text: "Continue with Google",
              isInverted: false,
            ),
            Gaps.v16,
            AuthButton(
              icon: SvgPicture.asset(
                'assets/images/apple-black-logo-svgrepo-com.svg',
                width: _svgIconSize,
                height: _svgIconSize,
              ),
              text: "Continue with Apple",
              isInverted: false,
            ),
            Gaps.v24,
            Stack(
              alignment: Alignment.center,
              children: [
                Divider(
                  thickness: 1,
                  color: Colors.grey.shade400,
                ),
                Container(
                  width: Sizes.size36,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Text(
                    "or",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Sizes.size12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Gaps.v6,
            GestureDetector(
              onTap: () => _onAccoountTap(context),
              child: AuthButton(
                icon: SvgPicture.asset(
                  'assets/images/user-alt-1-svgrepo-com.svg',
                  width: _svgIconSize,
                  height: _svgIconSize,
                ),
                text: "Create account",
                isInverted: true,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size16,
            horizontal: Sizes.size40,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Have an account already?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.size14,
                ),
              ),
              Gaps.h10,
              GestureDetector(
                onTap: () => _onLoginTap(context),
                child: Text(
                  "login",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.w600,
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
