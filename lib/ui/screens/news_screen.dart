import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/navigation_cubit.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:image_viewer/image_viewer.dart';

class NewsScreen extends StatelessWidget {
  final String text;

  NewsScreen({this.text}) : super();
  List test = [Colors.blue, Colors.green];
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CubitBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return Container(
        child: TikTokStyleFullPageScroller(
          contentSize: test.length,
          swipeThreshold: 0.2,
          swipeVelocityThreshold: 2000,
          animationDuration: const Duration(milliseconds: 300),
          builder: (BuildContext context, int index) {
            return Container(
                color: test[index],
                child: RaisedButton(
                  onPressed: () {
                    ImageViewer.showImageSlider(
                      images: [
                        'https://cdn.eso.org/images/thumb300y/eso1907a.jpg',
                        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg',
                        'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
                      ],
                      startingPosition: 1,
                    );
                  },
                  child: Text('Show slider'),

                  /*  Text(
                '$index',
                style: const TextStyle(fontSize: 48, color: Colors.white),
              ), */
                ));
          },
        ),
      );
    }));
  }
}
