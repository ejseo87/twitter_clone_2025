import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/features/settings/view_models/settings_vm.dart';

List<String> reportItemList = [
  "I just don't like it",
  "It's unlawful content under NetzDG",
  "It's spam",
  "Hate speech or symbols",
  "Nudity or sexual activity",
  "I just don't like it",
  "It's unlawful content under NetzDG",
  "It's spam",
  "Hate speech or symbols",
  "Nudity or sexual activity",
];

class ReportSheet extends ConsumerWidget {
  ReportSheet({super.key});

  final double _dividerThickness = 0.5;
  final _dividerColor = Colors.grey.shade400;

  void _onPressed(BuildContext context) {
    //int count = 0;
    Navigator.of(context).pop(); //popUntil((_) => count++ >= 3);
  }

  void _onTap(BuildContext context, int index) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Would like to report this?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Sizes.size20,
            ),
          ),
          content: Text(
            reportItemList[index],
            style: const TextStyle(
              fontSize: Sizes.size20,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text("Yes, go ahead."),
              onPressed: () => _onPressed(context),
            ),
            CupertinoDialogAction(
              child: const Text("No, cancel."),
              onPressed: () => _onPressed(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(settingsProvider).darkmode;
    return Container(
      height: size.height * 0.75,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Scaffold(
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Container(
              height: Sizes.size4,
              width: Sizes.size40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey.shade300,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.size10,
                vertical: Sizes.size6,
              ),
              child: Text(
                "Report",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Divider(
              thickness: _dividerThickness,
              color: _dividerColor,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.size20,
                vertical: Sizes.size6,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Why are you reporting this thread?",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Gaps.v10,
                  Text(
                    "Your report is anonymous, except if you're reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don't wait.",
                    style: TextStyle(
                      fontSize: Sizes.size14 + Sizes.size1,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            Gaps.v10,
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: reportItemList.length,
                separatorBuilder: (context, index) => Divider(
                  thickness: _dividerThickness,
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
                ),
                itemBuilder: (context, index) => ListTile(
                  onTap: () => _onTap(context, index),
                  selectedColor: Colors.grey.shade600,
                  title: Text(
                    reportItemList[index],
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: Sizes.size16,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
