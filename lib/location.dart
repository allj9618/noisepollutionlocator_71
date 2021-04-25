import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// geolocator 7.0.3
class Location extends StatefulWidget {
  @override
  _GeolocatorWidgetState createState() => _GeolocatorWidgetState();
}

class _GeolocatorWidgetState extends State<Location> {
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  // StreamSubscription<Position>? _positionStreamSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView.builder(
        itemCount: _positionItems.length,
        itemBuilder: (context, index) {
          final positionItem = _positionItems[index];

          if (positionItem.type == _PositionItemType.permission) {
            return ListTile(
              title: Text(positionItem.displayValue,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            );
          } else {
            return Card(
              child: ListTile(
                tileColor: Colors.blue,
                title: Text(
                  positionItem.displayValue,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: FloatingActionButton.extended(
              onPressed: () => setState(_positionItems.clear),
              label: Text("Clear"),
            ),
          ),
          Positioned(
            bottom: 80.0,
            right: 10.0,
            child: FloatingActionButton.extended(
              onPressed: () async {
                await Geolocator.getLastKnownPosition().then((value) => {
                  _positionItems.add(_PositionItem(
                      _PositionItemType.position, value.toString()))
                });

                setState(
                      () {},
                );
              },
              label: Text("Last Position"),
            ),
          ),
          Positioned(
            bottom: 150.0,
            right: 10.0,
            child: FloatingActionButton.extended(
                onPressed: () async {
                  await Geolocator.getCurrentPosition().then((value) => {
                    _positionItems.add(_PositionItem(
                        _PositionItemType.position, value.toString()))
                  });

                  setState(
                        () {},
                  );
                },
                label: Text("Current Position")),
          ),
          Positioned(
            bottom: 290.0,
            right: 10.0,
            child: FloatingActionButton.extended(
              onPressed: () async {
                await Geolocator.checkPermission().then((value) => {
                  _positionItems.add(_PositionItem(
                      _PositionItemType.permission, value.toString()))
                });
                setState(() {});
              },
              label: Text("Check Permission"),
            ),
          ),
          Positioned(
            bottom: 360.0,
            right: 10.0,
            child: FloatingActionButton.extended(
              onPressed: () async {
                await Geolocator.requestPermission().then((value) => {
                  _positionItems.add(_PositionItem(
                      _PositionItemType.permission, value.toString()))
                });
                setState(() {});
              },
              label: Text("Request Permission"),
            ),
          ),
        ],
      ),
    );
  }
  }

enum _PositionItemType {
  permission,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}