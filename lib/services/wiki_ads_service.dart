import 'package:dio/dio.dart';

class WikiAdsService {
  WikiAdsService({required Dio client}) : _client = client;
  final Dio _client;
  final _base = "https://wikispy.com";

  getAds() async {
    try {
      final response = await _client.get('/ads');
      if (response.statusCode != 200) {
        //throw exceptionn
      }

      //return ads model
    } catch (e) {
      // throw exception
    }
  }
}
