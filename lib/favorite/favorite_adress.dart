import 'dart:convert';

class FavoriteAddress {

  String _address;
  String _decibel;
  String _location;

  FavoriteAddress({String address, decibel, location}):
        _address = address, _decibel = decibel, _location = location;

  Map<String,dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["address"] = _address;
    map["decibel"] = _decibel;
    map["location"] = _location;
    return map;
  }
  factory FavoriteAddress.fromMap(Map<String, dynamic> map) => FavoriteAddress(
      address: map['address'],
      decibel: map['decibel'],
      location: map['location']
  );

    encodeFavorite(FavoriteAddress newFav) {
    Map<String, dynamic> mapObject = newFav.toMap();
    return jsonEncode(mapObject);
  }

   static decodedFavorite(String fav) {
    String jsonObjectString = fav;
    Map mapObject = jsonDecode(jsonObjectString);
    return FavoriteAddress.fromMap(mapObject);
  }

  String get location => _location;

  String get decibel => _decibel;

  String get address => _address;

}

