import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/navigation_cubit.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:galleryimage/galleryimage.dart';
//import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class OutrageScreen extends StatelessWidget {
  final String text;

  List<String> hardcodeImages = [
    'https://avatars.mds.yandex.net/get-zen_doc/1661842/pub_5dda8a6659178a1f5db6c1d5_5dda8b773efb4d2736dc382a/scale_1200',
    'https://149363556.v2.pressablecdn.com/wp-content/uploads/2019/04/Tallinn_Die_Kulturha_25788997.jpg',
    'https://favera.ru/img/2017/01/19/1441418_1484838060.jpg',
    'https://cdn.pixabay.com/photo/2018/11/25/14/27/estonia-3837540_1280.jpg'
  ];
  List<String> listOfUrls = [
    "https://cosmosmagazine.com/wp-content/uploads/2020/02/191010_nature.jpg",
    "https://scx2.b-cdn.net/gfx/news/hires/2019/2-nature.jpg",
    "https://isha.sadhguru.org/blog/wp-content/uploads/2016/05/natures-temples.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/7/77/Big_Nature_%28155420955%29.jpeg",
    "https://s23574.pcdn.co/wp-content/uploads/Singular-1140x703.jpg",
    "https://www.expatica.com/app/uploads/sites/9/2017/06/Lake-Oeschinen-1200x675.jpg",
  ];

  OutrageScreen({this.text}) : super();
  List test = [Colors.blue, Colors.green];
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CubitBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return Container(
        child: TikTokStyleFullPageScroller(
          contentSize: test.length,
          swipeThreshold: .1,
          swipeVelocityThreshold: 1000,
          animationDuration: const Duration(milliseconds: 500),
          builder: (BuildContext context, int index) {
            return Container(
                margin: EdgeInsets.only(top: 14),
                //color: test[index],
                child: Column(children: [
                  /*  GalleryImage(
                  titileGallery: 'adsfddf',
                  imageUrls: hardcodeImages,
                ) */
                  CarouselSlider(
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
                                    zoomedBackgroundColor:
                                        Colors.black.withOpacity(0.5),
                                    resetDuration:
                                        const Duration(milliseconds: 300),
                                    maxScale: 2.5,
                                  ),
                                ),
                              ));
                        },
                      );
                    }).toList(),
                  ),
                  Container(
                      //color: Colors.red,
                      height: MediaQuery.of(context).size.height * 0.28,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 4),
                            Text('Улица Пушкина. Дом колотушкина.'),
                            SizedBox(height: 20),
                            Text(
                              'Название поста с нарушением',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Text(
                              'Здесь длинное описание поста с нарушением. Здесь длинное описание поста с нарушением. Здесь длинное описание поста с нарушением. Здесь длинное описание поста с нарушением. Здесь длинное описание поста с нарушением. Здесь длинное описание поста с нарушением.',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(right: 24),
                                    child: Text(
                                      '28.01.2021 9:41  ',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),

                                      //textAlign: TextAlign.center,
                                    )),
                              ],
                            )
                          ]))
                ]));
          },
        ),
      );
    }));
  }
}
