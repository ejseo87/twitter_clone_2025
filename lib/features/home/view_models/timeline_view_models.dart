import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_2025/features/write/models/thread_model.dart';
import 'package:twitter_clone_2025/features/write/repos/threads_repo.dart';

class TimelineViewModel extends StreamNotifier<List<ThreadModel>> {
  late final ThreadsRepository _repository;

  @override
  Stream<List<ThreadModel>> build() {
    _repository = ref.read(threadsRepo);
    return getThread();
  }

  Stream<List<ThreadModel>> getThread() {
    print("TimelineViewModel : Stream<List<ThreadModel>> getThread()");
    return _repository.fetchTreads();
  }
}

final timelineProvider =
    StreamNotifierProvider<TimelineViewModel, List<ThreadModel>>(
  () => TimelineViewModel(),
);
/* 
    print("TimelineVIewMode in buid()");
    _repository = ref.read(threadsRepo);
    final result = await _repository.fetchTreads();
    final newList = result.docs.map(
      (doc) => ThreadModel.fromJson(
        doc.data(),
      ),
    );
    _list = newList.toList();
    print("TimeLineViewModel : _list=$_list");
    return _list;
*/
