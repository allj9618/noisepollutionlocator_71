import 'package:flutter_test/flutter_test.dart';
import 'package:noisepollutionlocator_71/favorite/favorite_adress.dart';

void main() {

  String addr = "Testgatan 7";
  String loc = "Solna";
  String dec = "5";

  FavoriteAddress newFav = new FavoriteAddress(address: addr, location: loc, decibel: dec);

  var map = new Map<String, dynamic>();
  map["address"] = addr;
  map["location"] = loc;
  map["decibel"] = dec;

  test('Test constructor', () {
    expect(newFav.address, "Testgatan 7");
    expect(newFav.location, "Solna");
    expect(newFav.decibel, "5");
  });

  test('Favourite address should be a map', (){
    expect(newFav.toMap(), map);
  });

  test('Favourite address should be encoded', (){
    expect(newFav.encodeFavorite(newFav), '{"address":"Testgatan 7","decibel":"5","location":"Solna"}');
  });

  test('Favourite address should be decoded from map', (){
    FavoriteAddress favoriteAddress = FavoriteAddress.decodedFavorite('{"address":"Testgatan 7","decibel":"5","location":"Solna"}');
    expect(favoriteAddress.address, "Testgatan 7");
    expect(favoriteAddress.decibel, "5");
    expect(favoriteAddress.location, "Solna");
  });
}
