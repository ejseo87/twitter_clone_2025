import "dart:io";
import "package:firebase_storage/firebase_storage.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:twitter_clone_2025/features/write/models/thread_model.dart";

class ThreadsRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> uploadImageFile({
    required File file,
    required String userId,
  }) async {
    final fileRef = _storage.ref().child(
        "/images/$userId/${DateTime.now().millisecondsSinceEpoch.toString()}");
    final tmp = await fileRef.putFile(file);
    return tmp.ref.getDownloadURL();
  }

  Future<void> saveThread(ThreadModel data) async {
    await _db.collection("threads").add(data.toJson());
  }

  Stream<List<ThreadModel>> fetchTreads() {
    print("ThreadsRepository in Stream<List<ThreadModel>> fetchTreads()");
    final result = _db
        .collection("threads")
        .orderBy("createAt", descending: true)
        .snapshots();
    final result2 = result.map(
      (event) => event.docs
          .map((doc) => ThreadModel.fromJson(
                doc.data(),
              ))
          .toList(),
    );
    print("result2.isEmpty = ${result2.first}");

    return result2;
  }
}

final threadsRepo = Provider((ref) => ThreadsRepository());
