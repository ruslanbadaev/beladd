import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/navigation_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

List<String> hardcodeImages = [
  'https://avatars.mds.yandex.net/get-zen_doc/1661842/pub_5dda8a6659178a1f5db6c1d5_5dda8b773efb4d2736dc382a/scale_1200',
  'https://149363556.v2.pressablecdn.com/wp-content/uploads/2019/04/Tallinn_Die_Kulturha_25788997.jpg',
  'https://favera.ru/img/2017/01/19/1441418_1484838060.jpg',
  'https://cdn.pixabay.com/photo/2018/11/25/14/27/estonia-3837540_1280.jpg'
];

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
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.5,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 2300),
          autoPlayCurve: Curves.easeInExpo,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: hardcodeImages.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  //height: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 6.0),
                  //decoration: BoxDecoration(color: Colors.amber),
                  child: FullScreenWidget(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: PinchZoom(
                        image: Image.network(i, fit: BoxFit.cover),
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
    }));
  }
}
