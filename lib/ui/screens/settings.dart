import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:urban_control/cubit/auth.dart';
import 'package:urban_control/cubit/navigation.dart';
import 'package:urban_control/controllers/profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:get/get.dart';

CSWidgetStyle brightnessStyle = const CSWidgetStyle(
    icon: const Icon(Icons.brightness_medium, color: Colors.black54));

class SettingsScreen extends StatelessWidget {
  SettingsScreen() : super();
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CubitBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return Container(
          child: CupertinoSettings(items: <Widget>[
        CSHeader('Имя'),
        CSControl(
          nameWidget: Text('${profileController.name}'),
        ),
        CSHeader('Email'),
        CSControl(
          nameWidget: Text('${profileController.email}'),
        ),
        CSHeader('ID'),
        CSControl(
          nameWidget: Text('${profileController.id}'),
        ),
        CSHeader('Размер текста'),
        CSSelection<int>(
          items: const <CSSelectionItem<int>>[
            CSSelectionItem<int>(text: 'Маленький', value: 0),
            CSSelectionItem<int>(text: 'Средний', value: 1),
            CSSelectionItem<int>(text: 'Большой', value: 2),
          ],
          onSelected: (index) {},
          currentSelection: 0,
        ),
        const CSHeader(''),
        CSButton(CSButtonType.DEFAULT, "Лицензия", () {}),
        CSButton(CSButtonType.DEFAULT, "Документация", () {}),
        const CSHeader(''),
        CSButton(CSButtonType.DESTRUCTIVE, 'Выход из аккаунта', () {
          context.cubit<AuthCubit>().logout(context);
        })
      ]));
    }));
  }
}
