import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_2025/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<void> uploadAvatar({
    required File file,
    required String fileName,
  }) async {
    final fileRef = _storage.ref().child("avatars/$fileName");
    await fileRef.putFile(file);
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update(data);
  }

  Future<List<UserProfileModel>> searchUsers({
    required String userId,
    required String keyword,
  }) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("users")
        .where("name", isGreaterThanOrEqualTo: keyword)
        .where("name", isLessThanOrEqualTo: "$keyword\uf8ff")
        .get();

    final List<UserProfileModel> searchedUsers = snapshot.docs
        .map((doc) => UserProfileModel.fromJson(doc.data()))
        .toList();
    return searchedUsers;
  }
}

final userRepo = Provider(
  (ref) => UserRepository(),
);
