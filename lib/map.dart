import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import "package:latlong/latlong.dart" as LatLng;
import 'package:noisepollutionlocator_71/WMSFeatureInterface.dart';
import 'favorite/favorite_add.dart';
import 'favorite/favorite_adress.dart';
import 'translations.dart';

const key = "AIzaSyDxSv3BsxRMJ59wrfvW49gLTXrHlUTa9VI";
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class Map extends StatefulWidget {
  @override
  _Map createState() => _Map();
}

class _Map extends State<Map> {
  final WMSFeatureInterface featureInterface = new WMSFeatureInterface();

  final Mode _mode = Mode.overlay;
  final MapController mapController = MapController();
  final List<Marker> markersList = [];
  bool markerPopupIsShowing = true;
  Marker popupMarker, marker;

  bool noiseLayerIsOn = true;
  double _currentOpacityValue = 0.4;

  LatLngData currentLatLongForPlaces;
  String currentLocation;
  int currentDB = 0;
  bool userCanSaveLastSearch = false;
  bool saveFavFromPress = false;

  get onTap => print("tapped");

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

  Future<Null> displaySearchBarPrediction(
      Prediction p, ScaffoldState scaffold, BuildContext context) async {
    if (p != null) {
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: key,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      removeAllMarkers(); // removes previous markers from map.

      mapController.move(
          LatLngData(LatLng.LatLng(lat, lng), 17.0).location, 17.0);

      // retrieve decibel value for location from api.
      LatLng.LatLng coordinates = new LatLng.LatLng(lat, lng);
      Future dBValue = featureInterface.getDecibel(coordinates);
      await dBValue.then((value) {
        int dB = value > 0 ? value : 0;
        setState(() => currentDB = dB);

        addMarkers(LatLng.LatLng(lat, lng), dB); // add marker and popup displaying db information to map.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text("Noise level: ${dB}dB ${p.description} - $lat/$lng")));
      }, onError: (e) {
        print(e);
      });
      setState(() {
        updateCurrentSearchPosition(p, lat, lng, currentDB);
      });
    }
  }

  void updateCurrentSearchPosition(
      Prediction p, double lat, double lng, int db) {
    if (currentDB > 0) {
      setState(() {
        currentDB = db;
        userCanSaveLastSearch = true;
        currentLocation = p.description;
        currentLatLongForPlaces = LatLngData(LatLng.LatLng(lat, lng), 17);
      });
    }
  }

  // adds markers and popupMarkers (information popups)
  addMarkers(LatLng.LatLng point, int dB) {

    // calculate map scale/zoom offset so that popup is displayed at the same distance above marker regardless of zoom level.
    final double slightOffset = 0.00000005; // initial distance between markers.
    final double curve = 591657550.500000; // constant to factor in zoom level.
    num scale = curve / (pow(2, mapController.zoom - 1));
    double popupOffset = slightOffset * scale;

    LatLng.LatLng popupPoint = LatLng.LatLng(
      point.latitude + popupOffset,
      point.longitude,
    );

    if (markersList.isNotEmpty) {
      markersList.clear();
    }

    // Marker holding onTap functionality
    Container markerContent = new Container(
        child: new GestureDetector(
      onTap: () {
        setState(() {
          if (markersList.contains(popupMarker)) {
            markersList.remove(popupMarker);
          } else {
            markersList.add(popupMarker);
          }
          markerPopupIsShowing = !markerPopupIsShowing;
        });
      },
      child: new Icon(Icons.location_pin, color: Colors.red, size: 40.0),
    ));

    // Information popup
    Container popupContainer = new Container(
      child: new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            markersList.remove(popupMarker);
            markerPopupIsShowing = false;
          });
        }, // remove popup if clicked.
        child: new Card(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.star_border_outlined),
                title: Text("Noise level: ${dB}dB"),
                subtitle: Text(point.toString()),
              ),
            ],
          ),
        ),
      ),
    );

    // Adding Marker to List.
    markersList.add(
      marker = new Marker(
        width: 80.0,
        height: 80.0,
        point: point,
        builder: (ctx) => markerContent,
      ),
    );

    // add popupMarker to list.
    markersList.add(popupMarker = new Marker(
      width: 300.0,
      height: 150.0,
      point: popupPoint,
      builder: (ctx) => popupContainer,
    ));

    setState(() {});
  }

  // add a pressable marker that displays information about location and dB.
  onLongPressHandler(LatLng.LatLng point) async {
    // get dB value for coordinate.
    int dB = await featureInterface.getDecibel(point);

    // remove all previous markers and marker + popup to  map.
    removeAllMarkers();
    addMarkers(point, dB);

    // update global vars.
    double lat = point.latitude;
    double lng = point.longitude;
    currentDB = dB;
    userCanSaveLastSearch = true;
    saveFavFromPress = true;
    currentLatLongForPlaces = LatLngData(LatLng.LatLng(lat, lng), 17);
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
              maxZoom: 18.4,
              interactive: true,
              onTap: (point) => onTapHandler(),
              onLongPress: (point) => onLongPressHandler(point),
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
                      transparent: true,
                      format: "image/png"),
                  opacity: noiseLayerIsOn ? _currentOpacityValue : 0.0,
                  backgroundColor: Colors.transparent),

              MarkerLayerOptions(markers: markersList),

              LocationOptions(
                onLocationUpdate: (LatLngData ld) {},
                onLocationRequested: (LatLngData ld) {
                  if (ld == null || ld.location == null) {
                    return;
                  }
                  mapController.onReady.then((result) {
                    mapController.move(ld.location, 14.0);
                    currentLocation = ld.location.toString();
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
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 10),
              child: ElevatedButton.icon(
                icon: Icon(Icons.search),
                //label: Text('Search Address'),
                label: Text(Translations.of(context).text('searchAddress')),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).scaffoldBackgroundColor),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).accentColor),
                ),
                onPressed: () {
                  _handleSearchBarButtonPress();
                },
              )),
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
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(bottom: 71, right: 145.0),
            child: FloatingActionButton(
              heroTag: "savebt",
              backgroundColor: userCanSaveLastSearch
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Colors.transparent,
              onPressed: () {
                if (userCanSaveLastSearch && saveFavFromPress) {
                  addToFavoritesFromPress();
                  setState(() {
                    userCanSaveLastSearch = !userCanSaveLastSearch;
                    saveFavFromPress = !saveFavFromPress;
                    currentDB = 0;
                  });
                } else if (!saveFavFromPress &&
                    userCanSaveLastSearch &&
                    currentDB > 0) {
                  addToFavorites();
                  setState(() {
                    userCanSaveLastSearch = !userCanSaveLastSearch;
                    currentDB = 0;
                  });
                }
              },
              child: Icon(
                Icons.save,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "noisebt",
        //label: Text("Noise Layer"),
        label: Text(Translations.of(context).text('noiseLayer')),
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

  void addToFavorites() {
    String address = currentLocation.substring(0, currentLocation.indexOf(','));
    String location = currentLocation.replaceAll(address, "");
    address.replaceAll(",", "");
    location = location.replaceFirst(RegExp(','), '', 0);

    FavoriteAddress fa = FavoriteAddress(
        address: address, location: location, decibel: currentDB.toString());
    fa.long = currentLatLongForPlaces.location.longitude.toString();
    fa.lat = currentLatLongForPlaces.location.latitude.toString();
    AddFavorite addFavorite = AddFavorite(fa, true);
    addFavorite.add();
  }

  void addToFavoritesFromPress() {
    String latS =
        "Lat: " + currentLatLongForPlaces.location.latitude.toStringAsFixed(8);
    String longS = "Long: " +
        currentLatLongForPlaces.location.longitude.toStringAsFixed(8);
    FavoriteAddress fa = FavoriteAddress(
        address: latS, location: longS, decibel: currentDB.toString());
    fa.long = currentLatLongForPlaces.location.longitude.toString();
    fa.lat = currentLatLongForPlaces.location.latitude.toString();
    AddFavorite addFavorite = AddFavorite(fa, true);
    addFavorite.add();
  }

  void removeAllMarkers() {
    if (markersList.isNotEmpty) {
      markersList.removeLast();
    }
  }

  // hides/removes information popup from map
  onTapHandler() {
    if (markersList.contains(popupMarker)) {
      markersList.remove(popupMarker);
      setState(() {});
    }
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
      //title: Center(child: Text('Noise Pollution Opacity')),
      title: Center(child: Text(Translations.of(context).text("opacity"))),
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
              //child: Text('Select'),
              child: Text(Translations.of(context).text("selectOpacity"))),
        )
      ],
    );
  }
}
