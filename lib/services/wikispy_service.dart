import 'package:dio/dio.dart';

class WikispyService {
  WikispyService({required Dio client}) : _client = client;
  final Dio _client;

  getAds() async {
    try {
      final response = await _client.get('');
      if (response.statusCode != 200) {
        //throw exceptionn
      }

      //return ads model
    } catch (e) {
      // throw exception
    }
  }
}
