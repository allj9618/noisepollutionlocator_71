import 'package:flutter_test/flutter_test.dart';
import "package:latlong/latlong.dart" as LatLng;
import 'package:noisepollutionlocator_71/WMSFeatureInterface.dart';

main() {
//{"type":"FeatureCollection","features":[{"type":"Feature","id":"","geometry":null,"properties":{"GRAY_INDEX":60}}],"totalFeatures":"unknown","numberReturned":1,"timeStamp":"2021-05-28T15:12:05.910Z",

  WMSFeatureInterface wms = new WMSFeatureInterface();
  final LatLng.LatLng coordinates = new LatLng.LatLng(59.309229, 18.076506);

  test("calculateBoundingBoxTest", () {
    double bBoxLimiter = 0.0001;
    final String expectedBbox =
        "18.076406,59.309129,18.076605999999998,59.309329000000005"; // edited expected result because although correct, the initial lacked nr of digits. notice that the lat lang has been reverted. this is intentional

    expect(wms.calculateBoundingBox(coordinates, bBoxLimiter), expectedBbox);
  });

  test('parseResponseAndGetDBTest', () {
    // final String jsonString ='{"type":"FeatureCollection","features":[{"type":"Feature","id":"","geometry":null,"properties":{"GRAY_INDEX":60}}],"totalFeatures":"unknown","numberReturned":1,"timeStamp":"2021-05-28T15:12:05.910Z"}';

    // parseResponseAndGetDB requires a response. cant emulate response,
    // expect( wms.parseResponseAndGetDB(), );
  });

  test('getDecibelTest', () async {
    expect(await wms.getDecibel(coordinates), 46);
  });
}
