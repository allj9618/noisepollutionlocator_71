import 'package:flutter_test/flutter_test.dart';
import 'package:noisepollutionlocator_71/WMSFeatureInterface.dart';
import "package:latlong/latlong.dart" as LatLng;


void main() {
//{"type":"FeatureCollection","features":[{"type":"Feature","id":"","geometry":null,"properties":{"GRAY_INDEX":60}}],"totalFeatures":"unknown","numberReturned":1,"timeStamp":"2021-05-28T15:12:05.910Z",

  WMSFeatureInterface wms = new WMSFeatureInterface();
  LatLng.LatLng coordinates = new LatLng.LatLng(18.076506,59.309229);

  Future dB = wms.getFeature(coordinates);
  dB.then((data) {
    String testString = data[0]['type'];
    print(testString);
  }, onError: (e) {
    print(e);
  });

  test('API Test', () {
 //test future.
  });
}

