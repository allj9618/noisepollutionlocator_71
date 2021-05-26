import 'dart:async';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

// From package example: https://pub.dev/packages/flutter_google_places/example
// Not working correctly.

const key = " ";
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  final Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _handlePressButton,
      child: Text("Search"),
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
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
      ),
      components: [Component(Component.country, "SE")],
    );

    displayPrediction(p, homeScaffoldKey.currentState);
  }
}

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
  if (p != null) {

    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: key,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;

    scaffold.showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng")),
    );
  }
}








