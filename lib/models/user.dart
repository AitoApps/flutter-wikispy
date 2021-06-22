import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String avatar;
  @HiveField(3)
  final String token;

  const User({
    required this.username,
    required this.email,
    required this.avatar,
    required this.token,
  });
  // String key() => email.hashCode.toString();
  // // factory User.fromJson(Map<String, dynamic> json) => User(
  // //       username: json['username'],
  // //       email: json['email'],
  // //       avatar: json['avatar'],
  // //       token: json['token'],
  // //     );

  static const empty = User(avatar: "", username: "", email: "", token: "");
}
