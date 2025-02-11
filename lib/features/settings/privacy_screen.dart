import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _notificaions = false;

  void _onNotificationChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notificaions = newValue;
    });
  }

  void _onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        leadingWidth: 100,
        leading: TextButton(
          onPressed: _onBackPressed,
          child: const Row(
            children: [
              FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: Sizes.size16,
                color: Colors.black,
              ),
              Gaps.h5,
              Text(
                "Back",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black,
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
            value: _notificaions,
            onChanged: _onNotificationChanged,
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
