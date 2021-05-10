import 'package:flutter/material.dart';
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
          zoom: 14.0,
        ),
        layers: [
          // Google maps layer
          TileLayerOptions(
            urlTemplate: 'https://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
            subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],

            backgroundColor: Colors.transparent
          ),

          // testing data from Stockholm.se  had to make changes to AndroidManifest to allow http, only done to debug for now.
          TileLayerOptions(

              wmsOptions: WMSTileLayerOptions(
                  baseUrl:
                  "http://kartor.miljo.stockholm.se/geoserver/wms?",
                  layers: [ "mfraster:bullerkartan-2012-allakallor"],
                  transparent: false,
                  format: "image/png"
              ),
              opacity: 0.7,
              backgroundColor: Colors.transparent




          ),

/*

          // layers from länsstyrelsens geodata server.
          TileLayerOptions(
            wmsOptions: WMSTileLayerOptions(
              baseUrl:
              "https://ext-geodata.lansstyrelsen.se/arcgis/services/WMS/LSTAB_WMS_bullernatverk/MapServer/WMSServer?",
              layers: [ "3", "4", "5","6"],
              transparent: true,
              format: "image/png"
            ),
              backgroundColor: Colors.transparent



          ),
    */


        ],
      ),
    );
  }
}
