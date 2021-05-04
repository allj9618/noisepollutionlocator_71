import 'package:noisepollutionlocator_71/favorite_adress.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test constructor', () {

    FavoriteAddress newFav = new FavoriteAddress(address: "Honnörsgatan 5", location: "Solna", decibel: "5");

    expect(newFav.address, "Honnörsgatan 5");
    expect(newFav.location, "Solna");
    expect(newFav.decibel, "5");
  });
}
