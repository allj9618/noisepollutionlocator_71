import 'package:noisepollutionlocator_71/favorites.dart';
import 'package:noisepollutionlocator_71/favorite_adress.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Add to favourite', () {
    List<String> _favorite = <String>[];
    FavoriteAddress newFav = new FavoriteAddress(address: "Honnörsgatan 5", location: "Solna", decibel: "5");
    _favorite.add(newFav.encodeFavorite(newFav));
    expect(_favorite[0], newFav.encodeFavorite(newFav));
  });

  testWidgets('Testing widget test', (WidgetTester tester) async {
    await tester.pumpWidget(Favorites());
  });
}



