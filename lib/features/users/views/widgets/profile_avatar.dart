import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone_2025/features/users/view_models/avatar_view_model.dart';

class ProfileAvatar extends ConsumerWidget {
  final String name;
  final bool hasAvatar;
  final String uid;
  const ProfileAvatar({
    super.key,
    required this.name,
    required this.hasAvatar,
    required this.uid,
  });
  void _onAvatarTap(BuildContext context, WidgetRef ref) async {
    final XFile? xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );
    if (xfile != null) {
      final file = File(xfile.path);
      ref.read(avatarProvider.notifier).uploadAvatar(context, file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;
    return GestureDetector(
      onTap: isLoading ? null : () => _onAvatarTap(context, ref),
      child: isLoading
          ? Container(
              alignment: Alignment.center,
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator(),
            )
          : CircleAvatar(
              radius: 28,
              backgroundColor: Colors.amber,
              foregroundImage: hasAvatar
                  ? NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/thread-ejseo-2025.firebasestorage.app/o/avatars%2F$uid?alt=media&haha=${DateTime.now().toString()}")
                  : null,
              child: Text(name),
            ),
    );
  }
}
/*                             
                            const CircleAvatar(
                              radius: 28,
                              foregroundColor: Colors.amber,
                              foregroundImage: NetworkImage(
                                  "https://picsum.photos/id/81/200/300"),
                            ),
 */
