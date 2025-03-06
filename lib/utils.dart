import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

bool isDartMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}

void showFirebaseErrorSnack({
  required BuildContext context,
  required Object? error,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      //showCloseIcon: true,
      //closeIconColor: Theme.of(context).primaryColor,
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
      ),
      content:
          Text((error as FirebaseException).message ?? "Something went wrong."),
    ),
  );
}

String makeDateTimeDifference(int createdAt) {
  final createdDateTime = DateTime.fromMillisecondsSinceEpoch(createdAt);
  final currentDateTime = DateTime.now();
  final diffMins = currentDateTime.difference(createdDateTime).inMinutes;
  final diffHours = currentDateTime.difference(createdDateTime).inHours;
  final diffDays = currentDateTime.difference(createdDateTime).inDays;

  if (diffMins < 60) {
    return "${diffMins}m";
  } else if (diffMins > 59 && diffMins < 1440) {
    return "${diffHours}h";
  } else {
    return "${diffDays}d";
  }
}
