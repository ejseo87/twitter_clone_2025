import 'package:flutter/material.dart';
import 'package:twitter_clone_2025/contants/gaps.dart';
import 'package:twitter_clone_2025/contants/sizes.dart';
import 'package:twitter_clone_2025/features/main_navigation/widgets/report_sheet.dart';

class ActionSheet extends StatefulWidget {
  const ActionSheet({super.key});

  @override
  State<ActionSheet> createState() => _ActionSheetState();
}

class _ActionSheetState extends State<ActionSheet> {
  bool _reportSelected = false;

  void _onReportSheet(BuildContext context) async {
    setState(() {
      _reportSelected = true;
    });
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => ReportSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.4,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
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
        body: Padding(
          padding: const EdgeInsets.only(
            left: Sizes.size20,
            right: Sizes.size20,
            bottom: Sizes.size20,
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(Sizes.size16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Sizes.size14,
                        horizontal: Sizes.size20,
                      ),
                      child: Text(
                        "Unfollow",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Sizes.size14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey.shade300,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Sizes.size14,
                        horizontal: Sizes.size20,
                      ),
                      child: Text(
                        "Mute",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Sizes.size14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.v20,
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(Sizes.size16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Sizes.size14,
                        horizontal: Sizes.size20,
                      ),
                      child: Text(
                        "Hide",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Sizes.size14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey.shade300,
                    ),
                    GestureDetector(
                      onTap: () => _onReportSheet(context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Sizes.size14,
                          horizontal: Sizes.size20,
                        ),
                        child: Text(
                          "Report",
                          style: TextStyle(
                            color: _reportSelected ? Colors.red : Colors.black,
                            fontSize: Sizes.size14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
