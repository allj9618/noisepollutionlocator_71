import 'package:flutter/material.dart';

class PopupMarker extends StatefulWidget {
  final Widget child;
  final String tooltip;
  final Function onTap;

  PopupMarker({@required this.child, this.tooltip, this.onTap});

  @override
  _MapMarkerState createState() => _MapMarkerState();
}

class _MapMarkerState extends State<PopupMarker> {
  final key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          final dynamic tooltip = key.currentState;
          tooltip.ensureTooltipVisible();
          widget.onTap();
        },
        child: Tooltip(
          key: key,
          message: widget.tooltip,
          child: widget.child,
        ));
  }
}