import 'package:beladd/ui/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/main_cubit.dart';
import 'package:beladd/cubit/navigation_cubit.dart';
import 'package:beladd/cubit/auth_cubit.dart';
import 'package:beladd/cubit/map_cubit.dart';
import 'package:beladd/ui/screens/news_screen.dart';
import 'package:beladd/ui/screens/outrage_screen.dart';
import 'package:beladd/ui/screens/map_screen.dart';
import 'package:beladd/ui/screens/google_map_screen.dart';
import 'package:beladd/ui/screens/settings_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

void main() async => {print(123), runApp(MyApp())};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(color: Colors.white),
        textTheme: TextTheme(body1: TextStyle(color: Colors.blueGrey)),
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(color: Colors.black12),
          textTheme: TextTheme(body1: TextStyle(color: Colors.white24))),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: MultiCubitProvider(
        providers: [
          CubitProvider<MainCubit>(
            create: (BuildContext context) => MainCubit(),
          ),
          CubitProvider<NavigationCubit>(
            create: (BuildContext context) => NavigationCubit(),
          ),
          CubitProvider<MapCubit>(
            create: (BuildContext context) => MapCubit(),
          ),
          CubitProvider<AuthCubit>(
            create: (BuildContext context) => AuthCubit(),
          ),
        ],
        child: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      MapScreen(),
      //GoogleMapScreen(),
      OutrageScreen(),
      NewsScreen(),
      SettingsScreen(),
      AuthScreen(),
      AuthScreen(),
      AuthScreen(),
    ];
    Map tabs = {
      'main': [
        TabItem(icon: Icons.place_rounded, title: 'Карта'),
        TabItem(icon: Icons.menu_book_rounded, title: 'Нарушения'),
        TabItem(icon: Icons.wysiwyg_rounded, title: 'Новости'),
        TabItem(icon: Icons.plumbing_rounded, title: 'Настройки'),
      ],
      'auth': [
        TabItem(icon: Icons.person_add_alt_1_rounded, title: 'Регистрация'),
        TabItem(icon: Icons.login_rounded, title: 'Вход'),
        TabItem(icon: Icons.person_search, title: 'Забыли пароль'),
      ]
    };
    return CubitBuilder<NavigationCubit, NavigationState>(
        builder: (navContext, navState) {
      return CubitBuilder<AuthCubit, AuthState>(
          builder: (authContext, authState) {
        return Scaffold(
            appBar: AppBar(
              toolbarHeight: 40,
              title: const Text(
                'Белореченский урбанист',
                style: TextStyle(color: Colors.blueGrey),
              ),
              //backgroundColor: Colors.white,
            ),
            body: pages[navState.page],
            bottomNavigationBar: authState.isAuth
                ? ConvexAppBar(
                    items: tabs['main'],
                    style: TabStyle.flip,
                    backgroundColor: Colors.white,
                    color: Colors.blueGrey,
                    activeColor: Colors.blueGrey,
                    initialActiveIndex: 0,
                    onTap: (index) => context
                        .cubit<NavigationCubit>()
                        .changePage(index, authState.isAuth),
                  )
                : ConvexAppBar(
                    items: tabs['auth'],
                    style: TabStyle.flip,
                    backgroundColor: Colors.white,
                    color: Colors.blueGrey,
                    activeColor: Colors.blueGrey,
                    initialActiveIndex: 0,
                    onTap: (index) => context
                        .cubit<NavigationCubit>()
                        .changePage(index, authState.isAuth),
                  ));
      });
    });
  }
}
