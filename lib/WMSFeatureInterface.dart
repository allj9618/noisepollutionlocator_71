
///  Class for fetching features from a WMS server.
///  @author Christoffer Öhman
import 'package:http/http.dart' as http;
import "package:latlong/latlong.dart" as LatLng;
import 'dart:convert';


class WMSFeatureInterface {




  Future<Map> getFeature(LatLng.LatLng coordinates) async {
    final double bBoxLimiter = 0.0001;
    final String featureURL =
        "http://kartor.miljo.stockholm.se/geoserver/mfraster/wms?SERVICE=WMS&";
    final String wmsLayer = "mfraster%3Abullerkartan-2012-allakallor";
    String bBox = (coordinates.latitude - bBoxLimiter).toString() +
        ',' +
        (coordinates.longitude - bBoxLimiter).toString() +
        ',' +
        (coordinates.latitude + bBoxLimiter).toString() +
        ',' +
        (coordinates.longitude + bBoxLimiter).toString();

    String parameters = "SERVICE=WMS"
        "&VERSION=1.1.0"
        "&REQUEST=GetFeatureInfo"
        "&FORMAT=application/json"
        "&TRANSPARENT=true"
        "&QUERY_LAYERS=" + wmsLayer +
        "&LAYERS=" + wmsLayer +
        "&exceptions=application/vnd.ogc.se_inimage"
            "&INFO_FORMAT=application/json"
            "&FEATURE_COUNT=50"
            "&X=50"
            "&Y=50"
            "&SRS=EPSG:4326"
            "&STYLES="
            "&WIDTH=101"
            "&HEIGHT=101"
            "&BBOX=" + bBox;

    final response = await http.get(Uri.parse(featureURL + parameters));
    //  final response = await http.get(Uri.parse("http://kartor.miljo.stockholm.se/geoserver/mfraster/wms?SERVICE=WMS&VERSION=1.1.0&REQUEST=GetFeatureInfo&FORMAT=application/json&TRANSPARENT=true&QUERY_LAYERS=mfraster%3Abullerkartan-2012-allakallor&LAYERS=mfraster%3Abullerkartan-2012-allakallor&exceptions=application/vnd.ogc.se_inimage&INFO_FORMAT=application/json&FEATURE_COUNT=50000&X=50&Y=50&SRS=EPSG:4326&STYLES=&WIDTH=101&HEIGHT=101&BBOX=18.076506,59.309229,18.084231,59.311414"));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch WMS feature');
    }

    print (response.body);
// parse the result from GeoJson to dynamic Map.
    Map<String, dynamic> result = jsonDecode(response.body);

    print (result);// testing

    return result;

  } // getFeature
} // FeatureInterface
