import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/navigation_cubit.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class PointMarker extends StatelessWidget {
  final String name;

  PointMarker({
    this.name,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CubitBuilder<NavigationCubit, NavigationState>(
        builder: (context, page) {
      return Container(
          child: Row(children: [
        Text('x'),
        Icon(Icons.control_point_duplicate_rounded)
      ]));
    }));
  }
}
