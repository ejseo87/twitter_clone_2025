class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String intro;
  final bool hasAvatar;
  final int followers;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.intro,
    required this.hasAvatar,
    required this.followers,
  });

  UserProfileModel.empty()
      : uid = "",
        email = "",
        name = "",
        intro = "",
        hasAvatar = false,
        followers = 0;

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "intro": intro,
      "hasAvatar": hasAvatar,
      "followers": followers,
    };
  }

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        email = json["email"],
        name = json["name"],
        intro = json["intro"],
        hasAvatar = json["hasAvatar"],
        followers = json["followers"];

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? intro,
    bool? hasAvatar,
    int? followers,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      intro: intro ?? this.intro,
      hasAvatar: hasAvatar ?? this.hasAvatar,
      followers: followers ?? this.followers,
    );
  }
}
