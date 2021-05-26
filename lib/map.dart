import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import "package:latlong/latlong.dart" as LatLng;

const key = "AIzaSyDxSv3BsxRMJ59wrfvW49gLTXrHlUTa9VI";
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class Map extends StatefulWidget {
  @override
  _Map createState() => _Map();
}

class _Map extends State<Map> {
  final Mode _mode = Mode.overlay;
  final MapController mapController = MapController();
  final List<Marker> markers = [];

  bool noiseLayerIsOn = true;
  double _currentOpacityValue = 0.4;

  void _opacityValueSliderDialog() async {
    final selectedOpacity = await showDialog<double>(
      context: context,
      builder: (context) =>
          OpacityValueSlider(initialOpacityValue: _currentOpacityValue),
    );
    if (selectedOpacity != null) {
      setState(() {
        _currentOpacityValue = selectedOpacity;
      });
    }
  }

  void onErrorSearchBar(PlacesAutocompleteResponse response) {
    print(response.errorMessage);
  }

  Future<void> _handleSearchBarButtonPress() async {
    Prediction p = await PlacesAutocomplete.show(
      // Must have
      // https://github.com/fluttercommunity/flutter_google_places/issues/165
      offset: 0,
      radius: 500,
      types: [],
      strictbounds: false,
      apiKey: key,
      onError: onErrorSearchBar,

      context: context,
      mode: _mode,
      language: "en",
      components: [Component(Component.country, "SE")],
    );

    displaySearchBarPrediction(p, homeScaffoldKey.currentState, context);
  }

Future<Null> displaySearchBarPrediction(Prediction p, ScaffoldState scaffold, BuildContext context) async {
  if (p != null) {
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: key,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;



    mapController.move(LatLngData(LatLng.LatLng(lat, lng), 17.0).location, 17.0);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${p.description} - $lat/$lng")));
  }
}

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              // Setting coordinates to Stockholm
              center: LatLng.LatLng(59.3103, 18.0806),
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
                  backgroundColor: Colors.transparent
              ),


              MarkerLayerOptions(
                markers: markers
              ),



              // Bullerdata layer from Stockholms stad
              TileLayerOptions(
                  wmsOptions: WMSTileLayerOptions(
                      baseUrl:
                          "http://kartor.miljo.stockholm.se/geoserver/wms?",
                      layers: ["mfraster:bullerkartan-2012-allakallor"],
                      transparent: false,
                      format: "image/png"),
                  opacity: noiseLayerIsOn ? _currentOpacityValue : 0.0,
                  backgroundColor: Colors.transparent),

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

              // Marker layer, used to display searched and favourite places testing stuff now



            ],
          ),
          Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 10),
              child: ElevatedButton.icon(
                icon: Icon(Icons.search),
                label: Text('Search Address'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).scaffoldBackgroundColor),
                  foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).accentColor),
                ),
                onPressed: () {
                  _handleSearchBarButtonPress();
                },
              )
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
              onPressed: _opacityValueSliderDialog,
            ),
          )
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

class OpacityValueSlider extends StatefulWidget {
  final double initialOpacityValue;

  OpacityValueSlider({Key key, this.initialOpacityValue}) : super(key: key);

  @override
  _OpacityValueSliderState createState() => _OpacityValueSliderState();
}

class _OpacityValueSliderState extends State<OpacityValueSlider> {
  double _currentOpacityValue;

  @override
  void initState() {
    super.initState();
    _currentOpacityValue = widget.initialOpacityValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Noise Pollution Opacity')),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 200),
      content: Container(
        child: Slider.adaptive(
          activeColor: Theme.of(context).accentColor,
          inactiveColor: Theme.of(context).focusColor,
          min: 0.1,
          max: 0.9,
          value: _currentOpacityValue,
          onChanged: (value) {
            setState(() {
              _currentOpacityValue = value;
            });
          },
        ),
      ),
      actions: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 90),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _currentOpacityValue);
            },
            child: Text('Select'),
          ),
        )
      ],
    );
  }
}
