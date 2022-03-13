import 'package:flutter_maps/Data/webservices/placeswebservices.dart';

import '../models/placesuggestion.dart';


class MapsRepository {
  final PlacesWebservices placesWebservices;

  MapsRepository(this.placesWebservices);

  Future<List<PlaceSuggestion>> fetchSuggestions(
      String place, String sessionToken) async {
    final suggestions =
        await placesWebservices.fetchSuggestions(place, sessionToken);
    return suggestions
        .map((suggestion) => PlaceSuggestion.fromjson(suggestion))
        .toList();
  }
}
