/*

class CountryCityModel {
  final List<String>? city;
  final List<String>? country;
  final List<PlaceType>? placeTypes;

  CountryCityModel({
    this.city,
    this.country,
    this.placeTypes,
  });

  factory CountryCityModel.fromJson(Map<String, dynamic> json) => CountryCityModel(
    city: json["city"] == null ? [] : List<String>.from(json["city"]!.map((x) => x)),
    country: json["country"] == null ? [] : List<String>.from(json["country"]!.map((x) => x)),
    placeTypes: json["placeTypes"] == null ? [] : List<PlaceType>.from(json["placeTypes"]!.map((x) => PlaceType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "city": city == null ? [] : List<dynamic>.from(city!.map((x) => x)),
    "country": country == null ? [] : List<dynamic>.from(country!.map((x) => x)),
    "placeTypes": placeTypes == null ? [] : List<dynamic>.from(placeTypes!.map((x) => x.toJson())),
  };
}

class PlaceType {
  final String? id;
  final String? name;

  PlaceType({
    this.id,
    this.name,
  });

  factory PlaceType.fromJson(Map<String, dynamic> json) => PlaceType(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
*/
