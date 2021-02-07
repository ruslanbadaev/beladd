/* import 'package:flutter/material.dart';
//import 'package:latlong/latlong.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/navigation_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_maps_marker/interactive_maps_marker.dart';

class GoogleMapScreen extends StatelessWidget {
  final String text;
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(36.0),
    topRight: Radius.circular(36.0),
  );
  GoogleMapScreen({this.text}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CubitBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return InteractiveMapsMarker(
        items: <MarkerItem>[
          MarkerItem(id: 1, latitude: 31.4673274, longitude: 74.2637687),
          MarkerItem(id: 2, latitude: 31.4718461, longitude: 74.3531591),
        ],
        center: LatLng(31.4906504, 74.319872),
        itemContent: (context, index) {
          return Text("Current Item $index");
        },
      );
    }));
  }
}
 */
