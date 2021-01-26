import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/main_cubit.dart';
import 'package:beladd/cubit/navigation_cubit.dart';
import 'package:beladd/ui/screens/news_screen.dart';
import 'package:beladd/ui/screens/outrage_screen.dart';
import 'package:beladd/ui/screens/map_screen.dart';
import 'package:beladd/ui/screens/settings_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

void main() => runApp(MyApp());

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
      OutrageScreen(),
      NewsScreen(),
      SettingsScreen()
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: const Text(
          'Белореченский урбанист',
          style: TextStyle(color: Colors.blueGrey),
        ),
        //backgroundColor: Colors.white,
      ),
      body: CubitBuilder<NavigationCubit, NavigationState>(
        builder: (_, navState) {
          return pages[navState.page];
          /* navState.page == 1
              ? MapScreen()
              : navState.page == 0
                  ? NewsScreen()
                  : SettingsScreen(); */
        },
      ),
      bottomNavigationBar: CubitBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        return ConvexAppBar(
          items: [
            TabItem(icon: Icons.place_rounded, title: 'Карта'),
            TabItem(icon: Icons.menu_book_rounded, title: 'Нарушения'),
            TabItem(icon: Icons.wysiwyg_rounded, title: 'Новости'),
            TabItem(icon: Icons.plumbing_rounded, title: 'Настройки'),
          ],
          style: TabStyle.flip,
          backgroundColor: Colors.white,
          //cornerRadius: 56,
          color: Colors.blueGrey,
          activeColor: Colors.blueGrey,
          initialActiveIndex: 0,
          onTap: context.cubit<NavigationCubit>().changePage,
        );
      }),
    );
  }
}
