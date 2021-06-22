import 'package:flutter_wikispy/models/user.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseHelper {
  static final _userTable = "user";

  static Future<void> setupDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
  }

  static Future<void> addUser(User user) async {
    final userBox = await Hive.openBox<User>(_userTable);
    await userBox.add(user);
  }

  static Future<List<User>> getUser() async {
    final userBox = await Hive.openBox<User>(_userTable);
    return userBox.values.toList();
  }

  static Future<void> clearUser() async {
    final userBox = await Hive.openBox<User>(_userTable);
    await userBox.clear();
  }

  static Future<String?> getUserToken() async {
    final userBox = await Hive.openBox<User>(_userTable);
    return userBox.getAt(0)?.token;
  }
}
