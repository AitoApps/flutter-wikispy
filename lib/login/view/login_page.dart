import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wikispy/login/login.dart';
import 'package:flutter_wikispy/login/view/login_form.dart';
import 'package:flutter_wikispy/repositories/authentication_repository.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('login')),
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: BlocProvider(
            create: (context) {
              return LoginBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
              );
            },
            child: LoginForm(),
          )),
    );
  }
}
