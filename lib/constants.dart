class UserModel {
  final String name;
  final String handle;
  final int followers;
  final String profilePicture;
  final String? bio;
  final int following;
  final int posts;

  UserModel({
    required this.name,
    required this.handle,
    required this.followers,
    required this.profilePicture,
     this.bio,
     required this.following,
    required this.posts
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map["name"] ?? "",
      handle: map["handle"] ?? "",
      followers: map["followers"] ?? 0,
      profilePicture: map["profilepic"] ?? "",
      bio: map["bio"] ?? "",
      following: map["following"] ?? 0,
      posts: map["numberPosts"] ?? 0,

    );
  }
}


UserModel? currentUser; // global variable
