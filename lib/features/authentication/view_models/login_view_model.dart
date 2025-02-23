import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone_2025/features/authentication/repos/authentication_repository.dart';
import 'package:twitter_clone_2025/utils.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _repository.emailSignIn(email, password),
    );
    if (state.hasError) {
      showFirebaseErrorSnack(
        context: context,
        error: state.error,
      );
    } else {
      context.go("/home");
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
