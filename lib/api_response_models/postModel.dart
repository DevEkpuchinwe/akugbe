class Post {
  final int id;
  final int userId;
  final String content;
  final String? image;
  final String? video;
  final String? thumbnail;
  final DateTime createdAt;
  final User user;

  Post({
    required this.id,
    required this.userId,
    required this.content,
    this.image,
    this.video,
    this.thumbnail,
    required this.createdAt,
    required this.user,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'],
     // content: json['content'],
    content: json['content'].toString(),
 image: json['image']?.toString(),
    video: json['video']?.toString(),
    thumbnail: json['thumbnail']?.toString(),
    createdAt: DateTime.parse(json['created_at']),
    /*  image: json['image'],
      video: json['video'],
      thumbnail: json['thumbnail'],
      createdAt: DateTime.parse(json['created_at']),*/
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String username;
  final String fullname;
  final String email;

  User({
    required this.id,
    required this.username,
    required this.fullname,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      fullname: json['fullname'],
      email: json['email'],
    );
  }
}
