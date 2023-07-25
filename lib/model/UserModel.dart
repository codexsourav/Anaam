class UserModel {
  UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.uname,
    required this.follower,
    required this.following,
    this.bio = "I am Useing Anaam",
    this.pic =
        "https://img.freepik.com/premium-photo/anime-kawaii-girl-generative-ai_259696-1902.jpg",
  });
  final String name;
  final String email;
  final String id;
  final String uname;
  final List follower;
  final List following;
  final String bio;
  final String pic;

  toJsonData() => {
        "name": name,
        "email": email,
        "id": id,
        "uname": uname,
        "follower": [],
        "following": [],
        "bio": bio,
        "setprofile": false,
        "pic": pic,
      };
}
