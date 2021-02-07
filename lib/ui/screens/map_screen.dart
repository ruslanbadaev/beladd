import 'package:beladd/cubit/map_cubit.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'package:beladd/ui/widgets/photo_slider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapScreen extends StatelessWidget {
  final String text;
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(36.0),
    topRight: Radius.circular(36.0),
  );
  MapScreen({this.text}) : super();

  @override
  Widget build(BuildContext context) {
    //List<Marker> markers = ;

    return CubitBuilder<MapCubit, MapState>(builder: (mapContext, mapState) {
      return Scaffold(
        body: SlidingUpPanel(
            backdropTapClosesPanel: true,
            minHeight: mapState.creationMode ? 48 : 0,
            borderRadius: radius,
            panel: Container(
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  height: 4,
                  margin: EdgeInsets.only(top: 12, bottom: 24),
                  child: Icon(Icons.view_carousel, color: Colors.blueGrey),
                ),
                /*          Container(
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    height: 4,
                    width: MediaQuery.of(context).size.width * 0.6,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.2,
                        top: 24)),  */
                ListView(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Вход',
                          style: TextStyle(fontSize: 36),
                          textAlign: TextAlign.center),
                      TextField(
                          //controller: nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.title_rounded),
                              border: OutlineInputBorder(),
                              labelText: "Введите название")),
                      TextField(
                          //controller: emailController,
                          keyboardType: TextInputType.text,
                          maxLines: 5,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.description_rounded),
                              border: OutlineInputBorder(),
                              labelText: "Введите описание")),
                      RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue, Colors.pink[200]],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Принять",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ])
              ]),
            ),
            body: new FlutterMap(
              options: new MapOptions(
                  center: new LatLng(51.5, -0.09),
                  zoom: 13.0,
                  onTap: (area) => {print('+++')},
                  onLongPress: (point) => {
                        context.cubit<MapCubit>().setMarker(point),
                        //context.cubit<MapCubit>().setMode(true),
                      }),
              layers: [
                new TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']),
                new MarkerLayerOptions(
                  markers: mapState.markers,
                ),
              ],
            )),
        floatingActionButton: mapState.creationMode
            ? FloatingActionButton(
                backgroundColor: Colors.orangeAccent,
                child: Icon(Icons.close_rounded),
                onPressed: () => {
                  //context.cubit<MapCubit>().setMode(false),
                  context.cubit<MapCubit>().removeMarker()
                },
              )
            : Container(),
      );
    });
  }
}
