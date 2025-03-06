import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone_2025/features/authentication/repos/authentication_repository.dart';
import 'package:twitter_clone_2025/features/users/models/user_profile_model.dart';
import 'package:twitter_clone_2025/features/users/repos/user_repo.dart';
import 'package:twitter_clone_2025/features/write/models/thread_model.dart';
import 'package:twitter_clone_2025/features/write/repos/threads_repo.dart';
import 'package:twitter_clone_2025/utils.dart';

class UploadThreadViewModel extends AsyncNotifier<void> {
  late final ThreadsRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(threadsRepo);
  }

  Future<void> uploadThread({
    required BuildContext context,
    required String text,
    required List<File>? files,
  }) async {
    final userId = ref.read(authRepo).user!.uid;
    final jsonProfile = await ref.read(userRepo).findProfile(userId);
    final profile = UserProfileModel.fromJson(jsonProfile!);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        List<String> imageUrl = [];
        if (files != null) {
          imageUrl = await Future.wait(
            files.map(
              (file) async {
                return await _repository.uploadImageFile(
                    file: file, userId: userId);
              },
            ),
          );
          //print("imageUrl = $imageUrl");
        }

        await _repository.saveThread(
          ThreadModel(
            creatorUid: userId,
            creator: profile.name,
            body: text,
            imageUrls: files != null ? imageUrl : [],
            likes: 0,
            replies: 0,
            createAt: DateTime.now().millisecondsSinceEpoch,
          ),
        );

        //throw ("todo"); //이 코드가 없으면 에러가 난다. 이유는 ?
      },
    );

    if (state.hasError) {
      print(
          "ThreadViewModel : if (state.hasError) : ${state.error.toString()} ");
      showFirebaseErrorSnack(
        context: context,
        error: state.error,
      );
    } else {
      context.pushReplacement("/home");
    }
  }
}

final uploadThreadProvider = AsyncNotifierProvider<UploadThreadViewModel, void>(
  () => UploadThreadViewModel(),
);


/* 
      if (file != null) {
        final task = await _repository.uploadImageFile(
          file,
          user!.uid,
        );
        if (task.metadata != null) {
          await _repository.saveThread(ThreadModel(
            creatorUid: user.uid,
            creator: "Anon",
            body: text,
            imageUrl: await task.ref.getDownloadURL(),
            likes: 0,
            replies: 0,
            createAt: DateTime.now().millisecondsSinceEpoch,
          ));
        }
      } else {
        await _repository.saveThread(ThreadModel(
          creatorUid: user!.uid,
          creator: "Anon",
          body: text,
          imageUrl: "",
          likes: 0,
          replies: 0,
          createAt: DateTime.now().millisecondsSinceEpoch,
        ));
      } */