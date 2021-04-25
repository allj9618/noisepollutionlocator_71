import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:flutter/material.dart';

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