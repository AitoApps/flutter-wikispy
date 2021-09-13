import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wikispy/authentication/authentication.dart';

class ListAds extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ListAds());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Ads"),
        actions: [
          ElevatedButton(
            child: const Text('Logout'),
            onPressed: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            },
          ),
        ],
      ),
      body: Center(
        child: Text("Authenticated"),
      ),
    );
  }
}
