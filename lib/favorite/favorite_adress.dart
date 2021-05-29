import 'dart:convert';

class FavoriteAddress {

  String _address;
  String _decibel;
  String _location;
  String _lat;
  String _long;

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


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteAddress &&
          runtimeType == other.runtimeType &&
          _address == other._address &&
          _decibel == other._decibel &&
          _location == other._location;

  @override
  int get hashCode =>
      _address.hashCode ^ _decibel.hashCode ^ _location.hashCode;

  encodeFavorite(FavoriteAddress newFav) {
    Map<String, dynamic> mapObject = newFav.toMap();
    return jsonEncode(mapObject);
  }

   static decodedFavorite(String fav) {
    String jsonObjectString = fav;
    Map mapObject = jsonDecode(jsonObjectString);
    return FavoriteAddress.fromMap(mapObject);
  }

  addWhiteSpace() {
    decibel = decibel.replaceFirst("-", " - ");
  }

  set decibel(String value) {
    _decibel = value;
  }

  String get location => _location;

  String get decibel => _decibel;

  String get address => _address;

  String get long => _long;

  String get lat => _lat;

  set lat(String value) {
    _lat = value;
  }

  set long(String value) {
    _long = value;
  }
}

