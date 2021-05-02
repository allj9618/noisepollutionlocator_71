import 'package:flutter/material.dart';
import 'package:flutter_map_arcgis/flutter_map_arcgis.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterMap(
          options: MapOptions(


            // Setting coordinates to Stockholm
            center: LatLng(59.3294, 18.0686),
            zoom: 9.0,
            plugins: [EsriPlugin()],
          ),

          layers: [
            TileLayerOptions(
              urlTemplate:
              'https://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
              subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],


              tileProvider: CachedNetworkTileProvider(),
            ),

            FeatureLayerOptions(

              // testing the polygon geodata.
              url: "https://ext-geodata.lansstyrelsen.se/arcgis/rest/services/WMS/LSTAB_WMS_bullernatverk/MapServer/3",
              geometryType: "polygon",

              onTap: (attributes, LatLng location) {
                print(attributes);
              },

              render: (dynamic attributes) {
                // You can render by attribute
                return PolygonOptions(
                    borderColor: Colors.blueAccent,
                    color: Colors.black12,
                    borderStrokeWidth: 2
                );
              },

            ),

          ],
        ),
    );
  }


}

/* Backup before changes // CÖ

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlatformMap(
        initialCameraPosition: CameraPosition(
          target: const LatLng(59.3350, 18.0406),
          zoom: 16.0,
        ),
        markers: Set<Marker>.of(
          [
            Marker(
              markerId: MarkerId('marker_1'),
              position: LatLng(59.3350, 18.0406),
              consumeTapEvents: true,
              infoWindow: InfoWindow(
                title: 'PO Hallmansgatan 10',
                snippet: "Noise pollution level: High",
              ),
              onTap: () {
                print("Marker tapped");
              },
            ),
          ],
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onTap: (location) => print('onTap: $location'),
        onCameraMove: (cameraUpdate) => print('onCameraMove: $cameraUpdate'),
        compassEnabled: true,
        onMapCreated: (controller) {
          Future.delayed(Duration(seconds: 2)).then(
                (_) {
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  const CameraPosition(
                    bearing: 270.0,
                    target: LatLng(59.3350, 18.0406),
                    tilt: 30.0,
                    zoom: 18,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

*/
