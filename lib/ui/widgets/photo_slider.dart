import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/navigation_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PhotoSlider extends StatelessWidget {
  final String name;
  final String form;
  final String area;
  final String status;

  PhotoSlider({
    this.name,
    this.form,
    this.area,
    this.status,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CubitBuilder<NavigationCubit, NavigationState>(
        builder: (context, page) {
      return CarouselSlider(
        options: CarouselOptions(height: 400.0),
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Text(
                    'text $i',
                    style: TextStyle(fontSize: 16.0),
                  ));
            },
          );
        }).toList(),
      );
    }));
  }
}
