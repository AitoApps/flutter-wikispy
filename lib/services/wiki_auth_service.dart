import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class WikiAuthService {
  Future<Map<String, dynamic>?> logIn(
      {required Map<String, dynamic> creds}) async {
    print(creds);
    try {
      final url = Uri.parse('https://wikispy.com/api/v1/login');
      final headers = {'Accept': 'application/json'};
      final response = await http.post(url, headers: headers, body: creds);
      final data = json.decode(response.body);

      print("REDOINE : $data}");
      print("REDOINE : ${data['message']}");
      return data;
    } catch (e) {
      print(e);
      return null;
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
    final url = Uri.parse('https://wikispy.com/api/v1/user');
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    print("header: $headers");

    final response = await http.post(url, headers: headers);
    final data = json.decode(response.body);

    if (data['user'] == null) {
      return null;
    }

    // add token to user info
    data['user']['token'] = token;

    print("REDOINE USER : $data");
    return data['user'];
  }
}
