import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/features/authentication/view_models/login_view_model.dart';
import 'package:twitter_clone_2025/features/authentication/view_models/signup_view_model.dart';
import 'package:twitter_clone_2025/features/authentication/views/sign_up_screen.dart';
import 'package:twitter_clone_2025/features/authentication/views/widgets/form_button.dart';
import 'package:twitter_clone_2025/features/settings/view_models/settings_vm.dart';

class LoginScreen extends ConsumerWidget {
  static const String routeName = "login";
  static const String routeURL = "/login";
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {};
  void _onSignupTap(BuildContext context) {
    context.pushNamed(SignUpScreen.routeName);
  }

  void _onSubmitTap(BuildContext context, WidgetRef ref) {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        ref.read(loginProvider.notifier).login(
              formData["email"]!,
              formData["password"]!,
              context,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(settingsProvider).darkmode;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "English (US)",
          style: TextStyle(
            fontSize: Sizes.size14,
            color: Colors.grey.shade500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
        ),
        child: Column(
          children: [
            Gaps.v48,
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.size20),
                color: isDark ? Colors.white : Colors.black,
              ),
              child: SvgPicture.network(
                "https://upload.wikimedia.org/wikipedia/commons/9/9d/Threads_%28app%29_logo.svg",
                colorFilter: ColorFilter.mode(
                  isDark ? Colors.black : Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Gaps.v64,
            Form(
              key: _formKey,
              child: Column(
                children: [
                  FractionallySizedBox(
                    child: TextFormField(
                      //autovalidateMode: AutovalidateMode.always,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Please write your email.";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue != null) {
                          formData['email'] = newValue;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size20,
                          vertical: Sizes.size24,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gaps.v16,
                  TextFormField(
                    //autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Please input password.";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['password'] = newValue;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size20,
                        vertical: Sizes.size24,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                  Gaps.v28,
                  GestureDetector(
                    onTap: () => _onSubmitTap(context, ref),
                    child: FormButton(
                      disabled: ref.watch(signUpProvider).isLoading,
                      text: "Log in",
                    ),
                  ),
                  Gaps.v20,
                  const Center(
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => _onSignupTap(context),
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    child: const Text(
                      "Create new account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                ),
              ),
              Gaps.v20,
              SvgPicture.network(
                "https://upload.wikimedia.org/wikipedia/commons/7/7b/Meta_Platforms_Inc._logo.svg",
                width: 60,
                colorFilter: ColorFilter.mode(
                  isDark ? Colors.grey.shade200 : Colors.grey.shade800,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
