import 'package:noisepollutionlocator_71/translations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  Locale _locale = new Locale('en','');

  Translations newTranslations = new Translations(locale: _locale);

  test('Test constructor', () {
    expect(newTranslations.locale, new Locale('en',''));
    expect(newTransaltions._localizedValues, null);
  });
}
