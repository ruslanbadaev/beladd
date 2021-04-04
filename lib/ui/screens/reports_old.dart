import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:urban_control/cubit/navigation.dart';
import 'package:urban_control/cubit/reports_old.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

class ReportsScreen extends StatelessWidget {
  final String text;

  ReportsScreen({this.text}) : super();
  List test = [Colors.blue, Colors.green];
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CubitBuilder<ReportsListCubit, ReportsListState>(
        builder: (reportsListContext, reportsListState) {
      return CubitBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        return Container(
          child: reportsListState.reports.length > 0
              ? TikTokStyleFullPageScroller(
                  contentSize: reportsListState.reports.length,
                  swipeThreshold: .1,
                  swipeVelocityThreshold: 1000,
                  animationDuration: const Duration(milliseconds: 500),
                  builder: (BuildContext context, int index) {
                    print(index);
                    return Container(
                        margin: EdgeInsets.only(top: 14),
                        child: Column(children: [
                          reportsListState.reports[index].photos.length > 0
                              ? CarouselSlider(
                                  options: CarouselOptions(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 0.8,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 6),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 2300),
                                    autoPlayCurve: Curves.easeInExpo,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  items: reportsListState.reports[index].photos
                                      .map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 6.0),
                                            child: FullScreenWidget(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: PinchZoom(
                                                  image: FancyShimmerImage(
                                                    boxFit: BoxFit.cover,
                                                    imageUrl:
                                                        'http://134.0.117.33:3000/${i['path']}',
                                                    shimmerBaseColor:
                                                        Colors.white,
                                                    shimmerHighlightColor:
                                                        Colors.blueGrey,
                                                    shimmerBackColor:
                                                        Colors.orange,
                                                  ),
                                                  /* Image.network(
                                                      'http://134.0.117.33:3000/${i['path']}',
                                                      fit: BoxFit.cover) */
                                                  zoomedBackgroundColor: Colors
                                                      .black
                                                      .withOpacity(0.5),
                                                  resetDuration: const Duration(
                                                      milliseconds: 300),
                                                  maxScale: 2.5,
                                                ),
                                              ),
                                            ));
                                      },
                                    );
                                  }).toList(),
                                )
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: Icon(
                                    Icons.no_photography_rounded,
                                    size: 128,
                                    color: Colors.grey,
                                  )),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(height: 4),
                                    Text(reportsListState
                                        .reports[index].creator),
                                    SizedBox(height: 0),
                                    Text(
                                      reportsListState.reports[index].title ==
                                              'legal'
                                          ? 'Легальное РС'
                                          : reportsListState
                                                      .reports[index].title ==
                                                  'illegal'
                                              ? 'Легальное РС'
                                              : 'Ветхое РС',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(12),
                                        child: Text(
                                          reportsListState.reports[index].text,
                                          style: TextStyle(fontSize: 16),
                                          textAlign: TextAlign.center,
                                        )),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(right: 24),
                                            child: Text(
                                              '${reportsListState.reports[index].date.replaceAll('T', ' ').split(':')[0]}:${reportsListState.reports[index].date.split(':')[1]}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            )),
                                      ],
                                    )
                                  ]))
                        ]));
                  },
                )
              : Container(
                  child: SpinKitRotatingCircle(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
        );
      });
    }));
  }
}
