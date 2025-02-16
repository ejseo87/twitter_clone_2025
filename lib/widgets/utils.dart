import 'package:flutter/material.dart';

bool isDartMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}
