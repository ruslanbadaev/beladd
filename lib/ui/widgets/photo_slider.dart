import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/navigation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class PhotoSlider extends StatelessWidget {
  final List photos;
  final bool autoPlay;
  final bool enableInfiniteScroll;

  PhotoSlider({
    this.photos,
    this.autoPlay,
    this.enableInfiniteScroll,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: enableInfiniteScroll,
        reverse: false,
        autoPlay: autoPlay,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 3),
        autoPlayCurve: Curves.easeInExpo,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: photos.map((photo) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                margin: EdgeInsets.symmetric(horizontal: 6.0),
                child: FullScreenWidget(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: PinchZoom(
                      image: Image.network(
                          'http://134.0.117.33:3000/${photo['path']}',
                          fit: BoxFit.cover),
                      zoomedBackgroundColor: Colors.black.withOpacity(0.5),
                      resetDuration: const Duration(milliseconds: 300),
                      maxScale: 2.5,
                    ),
                  ),
                ));
          },
        );
      }).toList(),
    );
  }
}
