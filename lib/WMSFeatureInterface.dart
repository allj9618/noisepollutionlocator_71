///  Class for fetching features from a WMS server.
///  @author Christoffer Öhman
  import "package:latlong/latlong.dart" as LatLng;

class WMSFeatureInterface {

  Future<Map> getFeature(LatLng.LatLng coordinates) async {

    final double bBoxLimiter = 0.0001;
    String bBox = (coordinates.latitude - bBoxLimiter).toString() + ',' +
        (coordinates.longitude - bBoxLimiter).toString() + ',' +
        (coordinates.latitude + bBoxLimiter).toString() + ',' +
        (coordinates.longitude + bBoxLimiter).toString();

    return null;
  } // getFeature
} // FeatureInterface
