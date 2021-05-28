import 'dart:convert';

///  Class for fetching features from a WMS server.
///  @author Christoffer Öhman
import 'package:http/http.dart' as http;
import "package:latlong/latlong.dart" as LatLng;

class WMSFeatureInterface {
  Future<Map> getFeature(LatLng.LatLng coordinates) async {
    final double bBoxLimiter = 0.0001;
    final String featureURL =
        "http://kartor.miljo.stockholm.se/geoserver/mfraster/wms?SERVICE=WMS&";
    String bBox = (coordinates.latitude - bBoxLimiter).toString() +
        ',' +
        (coordinates.longitude - bBoxLimiter).toString() +
        ',' +
        (coordinates.latitude + bBoxLimiter).toString() +
        ',' +
        (coordinates.longitude + bBoxLimiter).toString();


    final response = await http.get(Uri.parse(featureURL));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch WMS feature');
    }


    return null;
  } // getFeature
} // FeatureInterface
