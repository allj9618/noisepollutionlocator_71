import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show  rootBundle;
import 'package:noisepollutionlocator_71/translations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  Locale loc = Locale('en');

  Translations newTransl = new Translations(loc);

  test('Test constructor', () {
    expect(newTransl.locale, Locale('en'));
  });

  test('Test get language code', () {
    expect(newTransl.currentLanguage, 'en');
  });
}
