import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:latlong/latlong.dart';

class Map extends StatefulWidget {
  @override
  _Map createState() => _Map();
}

class _Map extends State<Map> {
  bool noiseLayerIsOn = true;
  double _currentSliderValue = 0.4;

  @override
  Widget build(BuildContext context) {
    final MapController mapController = MapController();

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              // Setting coordinates to Stockholm
              center: LatLng(59.3294, 18.0686),
              zoom: 14.0,
              plugins: <MapPlugin>[
                LocationPlugin(),
              ],
              interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
            layers: [
              // Google maps layer
              TileLayerOptions(
                  urlTemplate:
                      'https://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                  subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                  backgroundColor: Colors.transparent),

              // Bullerdata layer from Stockholms stad
              TileLayerOptions(
                  wmsOptions: WMSTileLayerOptions(
                      baseUrl:
                          "http://kartor.miljo.stockholm.se/geoserver/wms?",
                      layers: ["mfraster:bullerkartan-2012-allakallor"],
                      transparent: false,
                      format: "image/png"),
                  opacity: noiseLayerIsOn ? _currentSliderValue : 0.0,
                  backgroundColor: Colors.transparent),

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
              LocationOptions(
                onLocationUpdate: (LatLngData ld) {},
                onLocationRequested: (LatLngData ld) {
                  if (ld == null || ld.location == null) {
                    return;
                  }

                  mapController.onReady.then((result) {
                    mapController.move(ld.location, 14.0);
                  });
                },
                buttonBuilder: (BuildContext context,
                    ValueNotifier<LocationServiceStatus> status,
                    Function onPressed) {
                  return Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 70.0, right: 16.0),
                      child: FloatingActionButton(
                          heroTag: "locbt",
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: ValueListenableBuilder<LocationServiceStatus>(
                              valueListenable: status,
                              builder: (BuildContext context,
                                  LocationServiceStatus value, Widget child) {
                                switch (value) {
                                  case LocationServiceStatus.disabled:
                                  case LocationServiceStatus.permissionDenied:
                                  case LocationServiceStatus.unsubscribed:
                                    return const Icon(
                                      Icons.location_disabled,
                                      color: Colors.grey,
                                    );
                                    break;
                                  default:
                                    return Icon(
                                      Icons.location_searching,
                                      color: Theme.of(context).accentColor,
                                    );
                                    break;
                                }
                              }),
                          onPressed: () => onPressed()),
                    ),
                  );
                },
              ),
            ],
          ),
          Container(
            child: Image.asset('assets/dbkey.png'),
            alignment: Alignment.topRight,
            padding: const EdgeInsets.only(right: 10.0),
            width: 500,
            height: 200,
          ),
          Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(bottom: 71, right: 80.0),
              child: FloatingActionButton(
                  heroTag: "opacbt",
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: Icon(
                    Icons.opacity,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Card(
                            color: Colors.transparent,
                            margin: EdgeInsets.only(
                                left: 20, top: 480, right: 20, bottom: 200),
                            child: Slider(
                                activeColor: Theme.of(context).accentColor,
                                inactiveColor: Theme.of(context).focusColor,
                                min: 0.1,
                                max: 0.8,
                                value: _currentSliderValue,
                                onChanged: (value) {
                                  setState(() {
                                    _currentSliderValue = value;
                                    value = _currentSliderValue;
                                  });
                                }),
                          );
                        });
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "noisebt",
        label: Text("Noise Layer"),
        icon: Icon(Icons.layers),
        backgroundColor: noiseLayerIsOn ? Colors.green : Colors.red,
        onPressed: () {
          setState(() {
            noiseLayerIsOn = !noiseLayerIsOn;
          });
        },
      ),
    );
  }
}
