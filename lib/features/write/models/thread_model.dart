class ThreadModel {
  final String creatorUid;
  final String creator;
  final String body;
  final List<String>? imageUrls;
  int likes;
  int replies;
  int createAt;

  ThreadModel({
    required this.creatorUid,
    required this.creator,
    required this.body,
    required this.imageUrls,
    required this.likes,
    required this.replies,
    required this.createAt,
  });

  ThreadModel.fromJson(Map<String, dynamic> json)
      : creatorUid = json["creatorUid"],
        creator = json["creator"],
        body = json["body"],
        imageUrls = List<String>.from(json['imageUrls']),
        likes = json["likes"],
        replies = json["replies"],
        createAt = json["createAt"];

  Map<String, dynamic> toJson() {
    return {
      "creatorUid": creatorUid,
      "creator": creator,
      "body": body,
      "imageUrls": imageUrls,
      "likes": likes,
      "replies": replies,
      "createAt": createAt,
    };
  }
}
