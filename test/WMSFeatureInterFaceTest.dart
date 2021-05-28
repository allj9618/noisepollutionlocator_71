import 'package:flutter_test/flutter_test.dart';
import 'package:noisepollutionlocator_71/WMSFeatureInterface.dart';
import "package:latlong/latlong.dart" as LatLng;


void main() {


  WMSFeatureInterface wms = new WMSFeatureInterface();
  LatLng.LatLng coordinates = new LatLng.LatLng(18.076506,59.309229);

  Future future = wms.getFeature(coordinates);

  test('API Test', () {
 //test future.
  });
}

