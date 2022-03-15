// ignore_for_file: file_names, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_maps/Constants/strings.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  Future<dynamic> getPlaceLocation(String placeId, String sessionToken) async {
    try {
      Response response = await dio.get(placeLocationBaseUrl, queryParameters: {
        'place_id': placeId,
        'fields': 'geometry',
        'key': googleApiKey,
        'sessiontoken': sessionToken,
      });
      return response.data;
    } catch (error) {
      return Future.error(
          'Placelocation error', StackTrace.fromString(('this is its trace')));
    }
  }

// origin = current location
// destination = searched location

  Future<dynamic> getDirections(LatLng origin, LatLng destination) async {
    try {
      Response response = await dio.get(
        directionsaseUrl,
        queryParameters: {
          'origin': '${origin.latitude} , ${origin.longitude}',
          'destination': '${destination.latitude} , ${destination.longitude}',
          'key': googleApiKey,
        },
      );
      print('data success');
      return response.data;
    } catch (error) {
      return Future.error(
          'Placelocation error', StackTrace.fromString(('this is its trace')));
    }
  }
}
