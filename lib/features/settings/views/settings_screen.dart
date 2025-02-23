import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/features/authentication/repos/authentication_repository.dart';
import 'package:twitter_clone_2025/features/authentication/views/sign_up_screen.dart';
import 'package:twitter_clone_2025/features/settings/view_models/settings_vm.dart';
import 'package:twitter_clone_2025/features/settings/views/privacy_screen.dart';

class SettingsScreen extends ConsumerWidget {
  static String routeUrl = "/settings";
  static String routeName = "settings";
  const SettingsScreen({super.key});

  void _onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onPrivacyTap(BuildContext context) {
    context.pushNamed(PrivacyScreen.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(settingsProvider).darkmode;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () => _onBackPressed(context),
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: Sizes.size16,
                color: isDark ? Colors.white : Colors.black,
              ),
              Gaps.h5,
              Text(
                "Back",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: isDark,
            onChanged: (value) =>
                ref.read(settingsProvider.notifier).setDarkmode(value),
            title: const Text("Dark Mode"),
            subtitle: const Text("Light mode by default"),
          ),
          const ListTile(
            minLeadingWidth: 20,
            leading: FaIcon(
              FontAwesomeIcons.userPlus,
              size: Sizes.size20,
            ),
            title: Text("Follow and invite friends"),
          ),
          const ListTile(
            minLeadingWidth: 20,
            leading: FaIcon(
              FontAwesomeIcons.bell,
              size: Sizes.size24,
            ),
            title: Text("Notifications"),
          ),
          ListTile(
            onTap: () => _onPrivacyTap(context),
            minLeadingWidth: 20,
            leading: const FaIcon(
              FontAwesomeIcons.lock,
              size: Sizes.size24,
            ),
            title: const Text("Privacy"),
          ),
          const ListTile(
            minLeadingWidth: 20,
            leading: FaIcon(
              FontAwesomeIcons.circleUser,
              size: Sizes.size24,
            ),
            title: Text("Account"),
          ),
          const ListTile(
            minLeadingWidth: 20,
            leading: FaIcon(
              FontAwesomeIcons.circleQuestion,
              size: Sizes.size24,
            ),
            title: Text("Help"),
          ),
          const ListTile(
            minLeadingWidth: 20,
            leading: FaIcon(
              FontAwesomeIcons.circleInfo,
              size: Sizes.size24,
            ),
            title: Text("About"),
          ),
          Divider(
            thickness: 0.5,
            color: Colors.grey.shade500,
          ),
          ListTile(
            title: const Text("Log out (IOS)"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("Please don't go."),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("No"),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        ref.read(authRepo).signOut();
                        context.go(SignUpScreen.routeURL);
                      },
                      isDestructiveAction: true,
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
