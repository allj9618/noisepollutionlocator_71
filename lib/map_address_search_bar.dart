/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

// From package example: https://pub.dev/packages/flutter_google_places/example
// Not working correctly.

const key = "AIzaSyDxSv3BsxRMJ59wrfvW49gLTXrHlUTa9VI";
final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class SearchBar extends StatefulWidget {
  final MapController mapController;

  SearchBar({Key key, this.mapController}) : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final MapController mapController;



  final Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Search'),
      onPressed: () {
        _handlePressButton();
      },
    );
  }


  void onError(PlacesAutocompleteResponse response) {
    print(response.errorMessage);
  }

  Future<void> _handlePressButton() async {
    Prediction p = await PlacesAutocomplete.show(
      // Must have
      // https://github.com/fluttercommunity/flutter_google_places/issues/165
      offset: 0,
      radius: 1000,
      types: [],
      strictbounds: false,
      apiKey: key,
      onError: onError,

      context: context,
      mode: _mode,
      language: "en",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          gapPadding: 2,
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
      ),
      components: [Component(Component.country, "SE")],
    );

    displayPrediction(p, homeScaffoldKey.currentState, context);
  }
}

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold, BuildContext context) async {
  if (p != null) {
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: key,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${p.description} - $lat/$lng")));
  }
}
*/