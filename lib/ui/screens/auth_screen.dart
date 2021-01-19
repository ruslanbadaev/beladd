import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/navigation_cubit.dart';

class AuthScreen extends StatelessWidget {
  final String login;
  final String password;

  AuthScreen({this.login, this.password}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CubitBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return Container();
    }));
  }
}
