///  Class for fetching features from a WMS server.
///  @author Christoffer Öhman
import 'dart:convert';

import 'package:http/http.dart' as http;
import "package:latlong/latlong.dart" as LatLng;

class WMSFeatureInterface {
  Future<int> getDecibel(LatLng.LatLng coordinates) async {
    final double bBoxLimiter = 0.0001;
    final String featureURL =
        "http://kartor.miljo.stockholm.se/geoserver/mfraster/wms?SERVICE=WMS&";
    final String wmsLayer = "mfraster%3Abullerkartan-2012-allakallor";

    // longitude and latitude is entered in different order for different WMS versions.
    String bBox = (coordinates.longitude - bBoxLimiter).toString() +
        ',' +
        (coordinates.latitude - bBoxLimiter).toString() +
        ',' +
        (coordinates.longitude + bBoxLimiter).toString() +
        ',' +
        (coordinates.latitude + bBoxLimiter).toString();

    String parameters = "SERVICE=WMS"
            "&VERSION=1.1.0"
            "&REQUEST=GetFeatureInfo"
            "&FORMAT=application/json"
            "&TRANSPARENT=true"
            "&QUERY_LAYERS=" +
        wmsLayer +
        "&LAYERS=" +
        wmsLayer +
        "&exceptions=application/vnd.ogc.se_inimage"
            "&INFO_FORMAT=application/json"
            "&FEATURE_COUNT=50"
            "&X=50"
            "&Y=50"
            "&SRS=EPSG:4326"
            "&STYLES="
            "&WIDTH=101"
            "&HEIGHT=101"
            "&BBOX=" +
        bBox;

    final response = await http.get(Uri.parse(featureURL + parameters));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch WMS feature');
    }

    // print (response.body);
// parse the result from GeoJson to dynamic Map.
    Map<String, dynamic> result = jsonDecode(response.body);

    var features = result['features'];
    Map<String, dynamic> featuresMap =
        new Map<String, dynamic>.from(features[0]);
    var properties = featuresMap['properties'];
    Map<String, dynamic> propertiesMap =
        new Map<String, dynamic>.from(properties);

    int dBValue = propertiesMap['GRAY_INDEX'];

    // used for testing
    print("result printed from interface: $result)"); // used for testing
    String testString = dBValue.toString();
    print(" result from db api test: $testString");

    return dBValue;
  } // getFeature
} // FeatureInterface
