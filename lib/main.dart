import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_clone_2025/contants/Sizes.dart';
import 'package:twitter_clone_2025/features/settings/repos/settings_repo.dart';
import 'package:twitter_clone_2025/firebase_options.dart';
import 'package:twitter_clone_2025/router.dart';
import 'package:twitter_clone_2025/features/settings/view_models/settings_vm.dart';

/*
❯ flutter --version
Flutter 3.24.0 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 80c2e84975 (6 months ago) • 2024-07-30 23:06:49 +0700
Engine • revision b8800d88be
Tools • Dart 3.5.0 • DevTools 2.37.2
❯ flutter --version
Flutter 3.29.0 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 35c388afb5 (7 days ago) • 2025-02-10 12:48:41 -0800
Engine • revision f73bfc4522
Tools • Dart 3.7.0 • DevTools 2.42.2
*/

//https://imgur.com/Lr5lksD
void main() async {
  //go_router 최신버전 사용 시 선언
  //GoRouter.optionURLReflectsImperativeAPIs = true;
  //아래라인 없면 rendering 안되니 꼭 있어야함.
  WidgetsFlutterBinding.ensureInitialized();

  //firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final preferences = await SharedPreferences.getInstance();
  final repository = SettingsRepository(preferences);

  runApp(
    ProviderScope(
      overrides: [
        settingsProvider.overrideWith(
          () => SettingsViewModel(repository),
        ),
      ],
      child: const TwitterClone2025(),
    ),
  );
}

class TwitterClone2025 extends ConsumerWidget {
  const TwitterClone2025({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerPrivider),
      title: 'Thread Clone 2025',
      themeMode: ref.watch(settingsProvider).darkmode
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: Typography.blackMountainView,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          elevation: 2,
          color: Colors.grey.shade50,
        ),
        primaryColor: const Color(0xFF4F98E9),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF4F98E9),
        ),
        tabBarTheme: TabBarTheme(
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey.shade500,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.black,
        ),
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: Typography.whiteMountainView,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.grey.shade900,
          surfaceTintColor: Colors.grey.shade900,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.grey.shade100,
          ),
          iconTheme: IconThemeData(
            color: Colors.grey.shade100,
          ),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
        ),
        primaryColor: const Color(0xFF4F98E9),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF4F98E9),
        ),
        tabBarTheme: TabBarTheme(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade500,
        ),
        useMaterial3: false,
      ),
      //home: const MainNavigationScreen(),
    );
  }
}
