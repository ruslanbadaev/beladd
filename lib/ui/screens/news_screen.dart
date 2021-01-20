import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/navigation_cubit.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

class NewsScreen extends StatelessWidget {
  final String text;

  NewsScreen({this.text}) : super();
  List test = [];
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
              child: Text(
                '$index',
                style: const TextStyle(fontSize: 48, color: Colors.white),
              ),
            );
          },
        ),
      );
    }));
  }
}
