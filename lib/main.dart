import 'package:beladd/ui/screens/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/middleware/error.dart';
import 'package:beladd/cubit/main.dart';
import 'package:beladd/cubit/navigation.dart';
import 'package:beladd/cubit/auth.dart';
import 'package:beladd/cubit/map.dart';
import 'package:beladd/cubit/report.dart';
import 'package:beladd/cubit/reports.dart';
import 'package:beladd/cubit/ads.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:beladd/ui/screens/ads.dart';
import 'package:beladd/ui/screens/reports.dart';
import 'package:beladd/ui/screens/map.dart';
import 'package:beladd/ui/screens/settings.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async => {print(123), runApp(Phoenix(child: MyApp()))};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(color: Colors.white),
        textTheme: GoogleFonts.comfortaaTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.blueGrey),
        ),
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
          CubitProvider<ReportCubit>(
            create: (BuildContext context) => ReportCubit(),
          ),
          CubitProvider<ReportsListCubit>(
            create: (BuildContext context) => ReportsListCubit(),
          ),
          CubitProvider<AdsCubit>(
            create: (BuildContext context) => AdsCubit(),
          ),
        ],
        child: MainPage(),
      ),
      builder: EasyLoading.init(),
    );
  }
}

class Main extends StatelessWidget {
  List<Widget> pages = [
    MapScreen(),
    ReportsScreen(),
    AdsScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return CubitBuilder<NavigationCubit, NavigationState>(
        builder: (navContext, navState) {
      return pages[navState.page];
    });
  }
}

class MainNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CubitBuilder<NavigationCubit, NavigationState>(
        builder: (navContext, navState) {
      List<Widget> pages = [
        MapScreen(),
        ReportsScreen(),
        AdsScreen(),
        SettingsScreen(),
      ];
      List<TabItem> tabs = [
        TabItem(icon: Icons.place_rounded, title: 'Карта'),
        TabItem(
            icon: navState.page == 1
                ? Icons.autorenew_rounded
                : Icons.menu_book_rounded,
            title: 'Нарушения'),
        TabItem(
            icon: navState.page == 2
                ? Icons.autorenew_rounded
                : Icons.wysiwyg_rounded,
            title: 'Новости'),
        TabItem(icon: Icons.plumbing_rounded, title: 'Настройки'),
      ];
      return ConvexAppBar(
          items: tabs,
          style: TabStyle.flip,
          backgroundColor: Colors.white,
          color: Colors.blueGrey,
          activeColor: Colors.blueGrey,
          initialActiveIndex: 0,
          onTap: (index) => {
                if (index == 0)
                  context.cubit<MapCubit>().getAllMarkers({'context': context}),
                if (index == 1)
                  context
                      .cubit<ReportsListCubit>()
                      .getReports({'context': context}),
                if (index == 2)
                  context
                      .cubit<AdsCubit>()
                      .getAds({'context': context, 'isReload': true}),
                context.cubit<NavigationCubit>().changePage(index, false)
              });
    });
  }
}

class AuthNavBar extends StatelessWidget {
  List<TabItem> tabs = [
    TabItem(icon: Icons.person_add_alt_1_rounded, title: 'Регистрация'),
    TabItem(icon: Icons.login_rounded, title: 'Вход'),
    TabItem(icon: Icons.person_search, title: 'Забыли пароль'),
  ];

  @override
  Widget build(BuildContext context) {
    return CubitBuilder<AuthCubit, AuthState>(builder: (navContext, navState) {
      return ConvexAppBar(
        items: tabs,
        style: TabStyle.flip,
        backgroundColor: Colors.white,
        color: Colors.blueGrey,
        activeColor: Colors.blueGrey,
        initialActiveIndex: 0,
        onTap: context.cubit<AuthCubit>().changeTab,
      );
    });
  }
}

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthScreen();
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  initState() {
    super.initState();
    checkAuth();
    new Future.delayed(Duration.zero, () {
      context.cubit<MapCubit>().getAllMarkers({'context': context});
    });
  }

  checkAuth() async {
    Error().checkConnection(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isAuth = prefs.getString('token') != null;
    });
    if (isAuth) {}
  }

  bool isAuth = false;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          title: Row(children: [
            Icon(
              Icons.location_city_rounded,
              color: Colors.blueGrey,
            ),
            Text(
              '  Urban Control',
              style:
                  GoogleFonts.getFont('Caveat').apply(color: Colors.blueGrey),
            )
          ]),
        ),
        body: isAuth ? Main() : Auth(),
        bottomNavigationBar: isAuth ? MainNavBar() : AuthNavBar());
  }
}
