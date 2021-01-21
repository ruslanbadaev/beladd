import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/navigation_cubit.dart';
import 'package:beladd/ui/widgets/photo_slider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapScreen extends StatelessWidget {
  final String text;
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );
  MapScreen({this.text}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CubitBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        return SlidingUpPanel(
            backdropTapClosesPanel: true,
            minHeight: 48,
            borderRadius: radius,
            panel: Container(
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  height: 4,
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.all(12),
                ),
                SizedBox(height: 24),
                Container(
                    height: 200,
                    //padding: EdgeInsets.all(8),
                    child: PhotoSlider()),
                Text("This is the sliding Widget"),
                Text("This is the sliding Widget"),
              ]),
            ),
            body: new FlutterMap(
              options: new MapOptions(
                center: new LatLng(51.5, -0.09),
                zoom: 13.0,
              ),
              layers: [
                new TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']),
                new MarkerLayerOptions(
                  markers: [
                    new Marker(
                      width: 80.0,
                      height: 80.0,
                      point: new LatLng(51.5, -0.09),
                      builder: (ctx) => new Container(
                        child: new FlutterLogo(),
                      ),
                    ),
                  ],
                ),
              ],
            ));
      }),
    );
  }
}
