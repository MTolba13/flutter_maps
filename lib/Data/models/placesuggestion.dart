class PlaceSuggestion {
  late String placeId;
  late String description;

  PlaceSuggestion.fromjson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    description = json['description'];
  }
}
