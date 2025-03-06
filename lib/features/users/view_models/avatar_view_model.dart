import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_2025/features/authentication/repos/authentication_repository.dart';
import 'package:twitter_clone_2025/features/users/repos/user_repo.dart';
import 'package:twitter_clone_2025/features/users/view_models/users_view_model.dart';
import 'package:twitter_clone_2025/utils.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(userRepo);
  }

  Future<void> uploadAvatar(BuildContext context, File file) async {
    state = const AsyncValue.loading();
    final fileName = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(
      () async {
        await _repository.uploadAvatar(file: file, fileName: fileName);
        await ref.read(usersProvider.notifier).onAvatarUpload();
      },
    );
    if (state.hasError) {
      showFirebaseErrorSnack(
        context: context,
        error: state.error,
      );
    }
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(
  () => AvatarViewModel(),
);
