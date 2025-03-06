import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone_2025/common/main_navigation/main_navigation_screen.dart';
import 'package:twitter_clone_2025/features/authentication/repos/authentication_repository.dart';
import 'package:twitter_clone_2025/features/authentication/views/sign_up_screen.dart';
import 'package:twitter_clone_2025/features/authentication/views/login_screen.dart';
import 'package:twitter_clone_2025/features/settings/views/privacy_screen.dart';
import 'package:twitter_clone_2025/features/settings/views/settings_screen.dart';
import 'package:twitter_clone_2025/features/write/views/widgets/write_sheet.dart';

final routerPrivider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: "/home",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          if (state.subloc != SignUpScreen.routeURL &&
              state.subloc != LoginScreen.routeURL) {
            return SignUpScreen.routeURL;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          name: SignUpScreen.routeName,
          path: SignUpScreen.routeURL,
          builder: (context, state) => SignUpScreen(),
        ),
        GoRoute(
          name: LoginScreen.routeName,
          path: LoginScreen.routeURL,
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: "/:tab(home|search|activity|profile)",
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
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
  },
);
