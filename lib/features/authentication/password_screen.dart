import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/features/onborading/interests_screen.dart';
import 'package:twitter_clone_2025/witgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String _password = "";
  bool _obsecureText = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length > 8;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObsecureText() {
    _obsecureText = !_obsecureText;
    setState(() {});
  }

  void _onNextTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const InterestsScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: SvgPicture.asset(
            "assets/images/twitter-color-svgrepo-com.svg",
            width: 30,
            height: 30,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v28,
              Text(
                textAlign: TextAlign.start,
                "You'll need a password",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Gaps.v20,
              const Text("Make sure it's 8 characters or more."),
              Gaps.v36,
              TextField(
                controller: _passwordController,
                obscureText: _obsecureText,
                cursorColor: Theme.of(context).primaryColor,
                autocorrect: false,
                onEditingComplete: () {},
                decoration: InputDecoration(
                  hintText: "Password",
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          color: Colors.grey.shade500,
                          size: Sizes.size24,
                        ),
                      ),
                      Gaps.h10,
                      GestureDetector(
                        onTap: _toggleObsecureText,
                        child: FaIcon(
                          _obsecureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade500,
                          size: Sizes.size24,
                        ),
                      ),
                      Gaps.h10,
                      _isPasswordValid()
                          ? const Center(
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: Sizes.size24,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
              Gaps.v56,
              GestureDetector(
                onTap: _onNextTap,
                child: FormButton(
                  disabled: !_isPasswordValid(),
                  text: "Next",
                  buttonType: ButtonType.big,
                ),
              ),
            ],
          ),
        ),
      ),
    ); // 스카폴드
  }
}
