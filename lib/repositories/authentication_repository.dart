import 'dart:async';

import 'package:flutter_wikispy/database_helper.dart';
import 'package:flutter_wikispy/models/user.dart';
import 'package:flutter_wikispy/services/wiki_auth_service.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository({required WikiAuthService wikiAuthService})
      : _wikiAuthService = wikiAuthService;
  final _controller = StreamController<AuthenticationStatus>();
  final WikiAuthService _wikiAuthService;

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({required String email, required String password}) async {
    final creds = {"email": email, "password": password};
    final data = await _wikiAuthService.logIn(creds: creds);

    if (data != null) {
      if (data['message'] == "success") {
        //get user info;
        final user = await _wikiAuthService.getUser(token: data['token']);
        print("Redoine userwithtoken: $user");
        //save user info
        DatabaseHelper.clearUser();
        DatabaseHelper.addUser(user);
        _controller.add(AuthenticationStatus.authenticated);
      } else {
        _controller.add(AuthenticationStatus.unauthenticated);
      }
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
    DatabaseHelper.clearUser();
  }

  Future<User?> tryGetUser() async {
    //get token from storage
    final token = await DatabaseHelper.getUserToken();
    print("token: $token");
    if (token == null) return null;
    try {
      final user = await _wikiAuthService.getUser(token: token);
      return user;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  void dispose() {
    _controller.close();
    // close box
  }
}
