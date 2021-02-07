import 'package:flutter/material.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:beladd/ui/widgets/point_marker.dart';

class MapState {
  final List<Marker> markers;
  final Map warningMark;
  final bool creationMode;

  MapState(this.markers, this.warningMark, this.creationMode);
}

class MapCubit extends Cubit<MapState> {
  MapCubit()
      : super(MapState([
          new Marker(
            width: 80.0,
            height: 80.0,
            point: new LatLng(51.49, -0.098),
            builder: (ctx) => new Container(
                //child: new FlutterLogo(),
                ),
          ),
          new Marker(
            width: 80.0,
            height: 80.0,
            point: new LatLng(51.49, -0.098),
            builder: (ctx) => new Container(
              child: new FlutterLogo(),
            ),
          ),
          new Marker(
            width: 80.0,
            height: 80.0,
            point: new LatLng(51.5, -0.09),
            builder: (ctx) => new Container(
              child: new FlutterLogo(),
            ),
          )
        ], {}, false));

  void setMarker(point) {
    List<Marker> x = state.markers;
    x[0] = new Marker(
      width: 96.0,
      height: 96.0,
      point: point, //new LatLng(51.51, -0.095),
      builder: (ctx) => new Container(
          child: new Container(
              child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: []),
        Icon(
          Icons.maps_ugc_rounded,
          color: Colors.blue,
          size: 96,
        ),
      ]))),
    );

    emit(MapState(x, state.warningMark, true));
  }

  void removeMarker() {
    List<Marker> x = state.markers;
    x[0] = new Marker(
      width: 0.0,
      height: 0.0,
      builder: (ctx) => new Container(),
    );

    emit(MapState(state.markers, state.warningMark, false));
  }

  //void setMode(mode) => emit(MapState(state.markers, state.warningMark, mode));
}
