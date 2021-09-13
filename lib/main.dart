import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wikispy/app.dart';
import 'package:flutter_wikispy/bloc_observer.dart';
import 'package:flutter_wikispy/database_helper.dart';
import 'package:flutter_wikispy/repositories/authentication_repository.dart';
import 'package:flutter_wikispy/services/wiki_auth_service.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.setupDatabase();
  runApp(App(
      authenticationRepository:
          AuthenticationRepository(wikiAuthService: WikiAuthService())));
}
