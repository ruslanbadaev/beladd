import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/main_cubit.dart';
import 'package:beladd/cubit/navigation_cubit.dart';
import 'package:beladd/ui/screens/news_screen.dart';
import 'package:beladd/ui/screens/map_screen.dart';
import 'package:beladd/ui/screens/settings_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: const Text(
          'Белореченский урбанист',
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
      ),
      body: CubitBuilder<NavigationCubit, NavigationState>(
        builder: (_, navState) {
          return navState.page == 1
              ? MapScreen()
              : navState.page == 0
                  ? NewsScreen()
                  : SettingsScreen();
        },
      ),
      bottomNavigationBar: CubitBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        return ConvexAppBar(
          items: [
            TabItem(icon: Icons.account_tree, title: 'Новости'),
            TabItem(icon: Icons.map, title: 'Карта'),
            TabItem(icon: Icons.settings, title: 'Настройки'),
          ],
          backgroundColor: Colors.white,
          color: Colors.grey,
          activeColor: Colors.grey,
          initialActiveIndex: 2,
          onTap: context.cubit<NavigationCubit>().changePage,
        );
      }),
    );
  }
}