import 'dart:convert';

import 'package:dio/dio.dart';

class WikiAuthService {
  void logIn({required Map creds}) async {
    try {
      Response response =
          await Dio().post('https://wikispy.com/api/v1/login', data: creds);
      print(response.data.toString());
      var data = json.decode(response.data);
    } catch (e) {
      print(e);
    }
  }

  void storeToken({required String token}) async {
    print("store token : $token");
  }

  void logout({required String token}) async {
    try {
      Response response = await Dio().post('https://wikispy.com/api/v1/logout',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      print(response.data.toString());
      //delete token from storage
    } catch (e) {
      print(e);
    }
  }

  getUser({required String token}) async {
    Response response = await Dio().post('https://wikispy.com/api/v1/user',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    print(response.data.toString());
  }
}
