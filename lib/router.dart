import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone_2025/features/activity/activity_screen.dart';
import 'package:twitter_clone_2025/features/home/home_screen.dart';
import 'package:twitter_clone_2025/common/main_navigation_screen.dart';
import 'package:twitter_clone_2025/features/search/search_screen.dart';
import 'package:twitter_clone_2025/features/settings/privacy_screen.dart';
import 'package:twitter_clone_2025/features/settings/settings_screen.dart';
import 'package:twitter_clone_2025/features/users/user_profile_screen.dart';
import 'package:twitter_clone_2025/features/write/camera_screen.dart';
import 'package:twitter_clone_2025/features/write/widgets/write_sheet.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/:tab(|search|activity|profile)",
      name: MainNavigationScreen.routeName,
      builder: (context, state) {
        final tab = state.params["tab"]!;
        return MainNavigationScreen(tab: tab);
      },
    ),
    GoRoute(
      name: SettingsScreen.routeName,
      path: SettingsScreen.routeUrl,
      builder: (context, state) => const SettingsScreen(),
      routes: [
        GoRoute(
          name: PrivacyScreen.routeName,
          path: PrivacyScreen.routeUrl,
          builder: (context, state) => const PrivacyScreen(),
        ),
      ],
    ),
    GoRoute(
      name: WriteSheet.routeName,
      path: WriteSheet.routeUrl,
      pageBuilder: (context, state) => CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 200),
        child: const WriteSheet(
          url: "https://picsum.photos/id/81/200/300",
          text: "alice_liddell",
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final position = Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: position,
            child: child,
          );
        },
      ),
    ),
  ],
);
