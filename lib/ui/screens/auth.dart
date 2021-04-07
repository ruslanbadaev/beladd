import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:urban_control/controllers/cubit/auth.dart';

class AuthScreen extends StatelessWidget {
  final String login;
  final String password;

  AuthScreen({this.login, this.password}) : super();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
        body: CubitBuilder<AuthCubit, AuthState>(builder: (context, navState) {
      return Container(
        decoration: BoxDecoration(
          /**
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            begin: Alignment.topCenter,
            end: Alignment(0.8, 1.0),
            colors: [
              Colors.blueGrey,
              Colors.blueGrey,
            ],
            stops: [
              0,
              1,
            ],
          ), 
          */
          color: Colors.blueGrey,
          backgroundBlendMode: BlendMode.srcOver,
        ),
        child: Center(
          child: Container(
            height:
                MediaQuery.of(context).size.height * (10 - navState.tab) / 18,
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      navState.tab == 0
                          ? 'Регистрация'
                          : navState.tab == 2
                              ? 'Получить пароль на почту'
                              : 'Вход',
                      style: TextStyle(fontSize: 36),
                      textAlign: TextAlign.center),
                  if (navState.tab == 0)
                    TextField(
                        controller: nameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_rounded),
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(12.0),
                              ),
                            ),
                            labelText: "Введите имя")),
                  TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(12.0),
                            ),
                          ),
                          prefixIcon: Icon(Icons.email_rounded),
                          labelText: "Введите email")),
                  if (navState.tab != 2)
                    TextField(
                        controller: passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_open_rounded),
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(12.0),
                              ),
                            ),
                            labelText: "Введите пароль")),
                  RaisedButton(
                    color: Colors.blueGrey.withOpacity(.6),
                    onPressed: () {
                      if (navState.tab == 1)
                        context.cubit<AuthCubit>().login({
                          'context': context,
                          'email': emailController.text,
                          'password': passwordController.text
                        });
                      else if (navState.tab == 2)
                        context.cubit<AuthCubit>().login({
                          'context': context,
                          'email': emailController.text,
                          'password': passwordController.text
                        });
                      else
                        context.cubit<AuthCubit>().registration({
                          'context': context,
                          'name': nameController.text,
                          'email': emailController.text,
                          'password': passwordController.text
                        });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Container(
                        constraints: BoxConstraints(minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Принять",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      );
    }));
  }
}
