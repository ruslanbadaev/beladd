import 'package:flutter/material.dart';
import 'package:cubit/cubit.dart';
import 'package:dio/dio.dart';
import 'package:urban_control/middleware/error.dart';
import 'package:urban_control/middleware/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:urban_control/ui/widgets/photo_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ndialog/ndialog.dart';

class MapState {
  final List<Marker> markers;
  final Map warningMark;
  final bool creationMode;

  MapState(this.markers, this.warningMark, this.creationMode);
}

class MapCubit extends Cubit<MapState> {
  Dio dio = new Dio();
  MapCubit()
      : super(MapState([
          new Marker(
            width: 80.0,
            height: 80.0,
            point: new LatLng(44.845875, 39.801735),
            builder: (ctx) => new Container(),
          ),
        ], {}, false));

  void setMarker(point) {
    List<Marker> x = state.markers;
    x[0] = new Marker(
      width: 96.0,
      height: 96.0,
      point: point,
      builder: (ctx) => new Container(
          child: new Container(
              child: Column(children: [
        Icon(
          Icons.filter_center_focus_rounded,
          color: Colors.blue,
          size: 96,
        ),
      ]))),
    );

    emit(MapState(x, state.warningMark, true));
  }

  Future getAllMarkers(args) async {
    try {
      List<Marker> markers = [
        new Marker(
          width: 0.0,
          height: 0.0,
          point: new LatLng(44.845875, 39.801735),
          builder: (ctx) => new Container(),
        )
      ];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      dio.options.headers["authorization"] = "Bearer $token";
      Response response = await dio.get('$API_URL/reports/all',
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        for (Map report in response.data) {
          markers.add(new Marker(
            width: 48.0,
            height: 48.0,
            point: new LatLng(report['latitude'], report['longitude']),
            builder: (ctx) => new Container(
                child: new Container(
                    child: Column(children: [
              InkWell(
                onTap: () => DialogBackground(
                  dialog: AlertDialog(
                      backgroundColor: Colors.white.withOpacity(1),
                      title: Container(
                          height: 280,
                          child: PhotoSlider(
                              autoPlay: false,
                              enableInfiniteScroll: false,
                              photos: report['files'])),
                      content: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0)),
                          padding: EdgeInsets.all(24),
                          child: Text(
                            '${report['text']}',
                            textAlign: TextAlign.center,
                          ))),
                ).show(args['context']),
                child: Icon(
                  Icons.place_rounded,
                  color: report['title'] == 'illegal'
                      ? Colors.red
                      : report['title'] == 'legal'
                          ? Colors.blue
                          : Colors.orange,
                  size: 48,
                ),
              ),
            ]))),
          ));
        }

        emit(MapState(markers, state.warningMark, state.creationMode));
        return markers;
      } else {
        Error().checkRequestError(args['context'], response.statusCode,
            getAllMarkers, {'context': args['context']});
        return markers;
      }
    } catch (e) {
      print('getAllMarkers error: $e');
      Error().checkConnection(args['context']);
      return [];
    }
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
}
