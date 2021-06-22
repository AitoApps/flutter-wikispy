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
    yield AuthenticationStatus.authenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({required String email, required String password}) async {
    final creds = {"email": email, "password": password};
    _wikiAuthService.logIn(creds: creds);
    _controller.add(AuthenticationStatus.authenticated);
    // await Future.delayed(
    //   Duration(milliseconds: 300),
    //   () => _controller.add(AuthenticationStatus.authenticated),
    // );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
    DatabaseHelper.clearUser();
  }

  Future<User?> tryGetUser() async {
    //get token from storage
    final token = await DatabaseHelper.getUserToken();
    if (token == null) return null;
    try {
      final user = await _wikiAuthService.getUser(token: token);
      return user;
    } on Exception {
      return null;
    }
  }

  void dispose() {
    _controller.close();
    // close box
  }
}
