import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/features/settings/view_models/settings_vm.dart';

class PrivacyScreen extends ConsumerWidget {
  static String routeUrl = "privacy";
  static String routeName = "privacy";
  const PrivacyScreen({super.key});

  void _onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
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
        title: const Text("Privacy"),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: false,
            onChanged: (value) {},
            title: const Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.lock,
                  size: Sizes.size24,
                ),
                Gaps.h16,
                Text("Private Profile"),
              ],
            ),
          ),
          ListTile(
            minLeadingWidth: 20,
            leading: const FaIcon(
              FontAwesomeIcons.at,
              size: Sizes.size24,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Mentions"),
                Text(
                  "Everyone",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.chevronRight,
                size: Sizes.size16,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          ListTile(
            minLeadingWidth: 20,
            leading: const FaIcon(
              FontAwesomeIcons.bellSlash,
              size: Sizes.size24,
            ),
            title: const Text("Muted"),
            trailing: IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.chevronRight,
                size: Sizes.size16,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          ListTile(
            minLeadingWidth: 20,
            leading: const FaIcon(
              FontAwesomeIcons.eyeSlash,
              size: Sizes.size24,
            ),
            title: const Text("Hidden Words"),
            trailing: IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.chevronRight,
                size: Sizes.size16,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          ListTile(
            minLeadingWidth: 20,
            leading: const FaIcon(
              FontAwesomeIcons.users,
              size: Sizes.size24,
            ),
            title: const Text("Profiles you follow"),
            trailing: IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.chevronRight,
                size: Sizes.size16,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          Divider(
            thickness: 0.5,
            color: Colors.grey.shade500,
          ),
          ListTile(
            title: const Text("Other privacy settings"),
            trailing: IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.arrowUpRightFromSquare,
                size: Sizes.size16,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: Sizes.size16,
              right: Sizes.size28,
            ),
            child: Text(
              "Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.",
              style: TextStyle(height: 1.1),
            ),
          ),
          ListTile(
            minLeadingWidth: 20,
            leading: const FaIcon(FontAwesomeIcons.circleXmark),
            title: const Text("Blocked profiles"),
            trailing: IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.arrowUpRightFromSquare,
                size: Sizes.size16,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          ListTile(
            minLeadingWidth: 20,
            leading: const FaIcon(FontAwesomeIcons.heartCrack),
            title: const Text("Hide likes"),
            trailing: IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.arrowUpRightFromSquare,
                size: Sizes.size16,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
