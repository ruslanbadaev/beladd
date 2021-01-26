import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/navigation_cubit.dart';
import 'package:beladd/ui/widgets/photo_slider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class MapScreen extends StatelessWidget {
  final String text;
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(36.0),
    topRight: Radius.circular(36.0),
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
                SizedBox(height: 24),
                Container(
                    height: 200,
                    //padding: EdgeInsets.all(8),
                    child: PhotoSlider()),
                SizedBox(height: 8),
                Text("Some text"),
                Text("Some text"),
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
