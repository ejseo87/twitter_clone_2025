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
