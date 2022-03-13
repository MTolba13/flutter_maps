// ignore_for_file: file_names, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_maps/Constants/strings.dart';

class PlacesWebservices {
  late Dio dio;

  PlacesWebservices() {
    BaseOptions options = BaseOptions(
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> fetchSuggestions(
      String place, String sessionToken) async {
    try {
      Response response = await dio.get(suggestionsBaseUrl, queryParameters: {
        'input': place,
        'types': 'address',
        'components': 'country:eg',
        'key': googleApiKey,
        'sessiontoken': sessionToken,
      });
      return response.data['predictions'];
    } catch (error) {
      print(error.toString());
      return [];
    }
  }
}
