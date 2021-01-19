import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/navigation_cubit.dart';

class NewsScreen extends StatelessWidget {
  final String text;

  NewsScreen({this.text}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CubitBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return Container();
    }));
  }
}
