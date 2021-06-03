///  Class for fetching features from a WMS server.
///  @author Christoffer Öhman
import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:latlong/latlong.dart" as LatLng;

class WMSFeatureInterface {
  Future<int> getDecibel(LatLng.LatLng coordinates) async {

    // params
    final double boundingBoxSize = 0.0001; // size of bounding box to be created around coordinates.
    final String featureURL =
        "http://kartor.miljo.stockholm.se/geoserver/mfraster/wms?SERVICE=WMS&";
    final String wmsLayer = "mfraster%3Abullerkartan-2012-allakallor";
    String bBox = calculateBoundingBox(coordinates, boundingBoxSize);  // bBox longitude and latitude is entered differently in different WMS versions.
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

    http.Response response = await httpDataFetcher(featureURL, parameters);
    int dBValue = parseResponseAndGetDB(response);
    return dBValue;
  }

  // BoundingBox is a defined area from where to retrieve features from wms server.
  // WMS Server version requires lat before long. so they will be reversed before being returned.
  String calculateBoundingBox(LatLng.LatLng coordinates, double bBoxLimiter) {
    String bBox = (coordinates.longitude - bBoxLimiter).toString() +
        ',' +
        (coordinates.latitude - bBoxLimiter).toString() +
        ',' +
        (coordinates.longitude + bBoxLimiter).toString() +
        ',' +
        (coordinates.latitude + bBoxLimiter).toString();
    return bBox;
  }

  // fetch data from API
  Future<http.Response> httpDataFetcher(
      String uri, String parameters) async {
    final response = await http.get(Uri.parse(uri + parameters));
    int statusCode = response.statusCode;

    // throw error if unable to fetch data.
    if (statusCode != 200) {
      throw Exception(
          'Failed to retrieve data from server. statuscode:$statusCode');
    }
    return response;
  }

  // parse geoJSON response and return the decibel value
  int parseResponseAndGetDB(http.Response response) {
    //Convert geoJSON to Map.
    Map<String, dynamic> result = jsonDecode(response.body);

    // Map WMS features
    var features = result['features'];

    Map<String, dynamic> featuresMap =
        new Map<String, dynamic>.from(features[0]);

    // Map WMS feature properties
    var properties = featuresMap['properties'];
    Map<String, dynamic> propertiesMap =
        new Map<String, dynamic>.from(properties);

    //retrieve and return decibel value
    return propertiesMap['GRAY_INDEX']; //
  } // parseResponse
} // FeatureInterface
