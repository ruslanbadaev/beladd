import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/navigation_cubit.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:beladd/cubit/auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  final String login;
  final String password;

  AuthScreen({this.login, this.password}) : super();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(body: CubitBuilder<NavigationCubit, NavigationState>(
        builder: (context, navState) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            begin: Alignment.topCenter,
            end: Alignment(0.8, 1.0),
            colors: [
              Color(0xfff44336),
              Color(0xff2196f3),
            ],
            stops: [
              0,
              1,
            ],
          ),
          backgroundBlendMode: BlendMode.srcOver,
        ),
/*         child: PlasmaRenderer(
          type: PlasmaType.infinity,
          particles: 43,
          color: Color(0xaf2b1cbd),
          blur: 0.44,
          size: 0.5830834600660535,
          speed: 1.71,
          offset: 0,
          blendMode: BlendMode.plus,
          variation1: 0.24,
          variation2: 0.7,
          variation3: 0.16,
          rotation: 0, */
        child: Center(
          child: Container(
            height:
                MediaQuery.of(context).size.height * (10 - navState.page) / 10,
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(.7),
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      navState.page == 4
                          ? 'Регистрация'
                          : navState.page == 6
                              ? 'Получить пароль на почту'
                              : 'Вход',
                      style: TextStyle(fontSize: 36),
                      textAlign: TextAlign.center),
                  if (navState.page == 4)
                    TextField(
                        controller: nameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_rounded),
                            border: OutlineInputBorder(),
                            labelText: "Введите имя")),
                  TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded),
                          border: OutlineInputBorder(),
                          labelText: "Введите email")),
                  if (navState.page != 6)
                    TextField(
                        controller: passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_open_rounded),
                            border: OutlineInputBorder(),
                            labelText: "Введите пароль")),
                  RaisedButton(
                    onPressed: () {
                      if (navState.page == 5)
                        context.cubit<AuthCubit>().login(context,
                            emailController.text, passwordController.text);
                      else if (navState.page == 6)
                        context.cubit<AuthCubit>().login(context,
                            emailController.text, passwordController.text);
                      else
                        context.cubit<AuthCubit>().register(nameController.text,
                            emailController.text, passwordController.text);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.pink[200]],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
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
        //),
      );
    }));
  }
}
