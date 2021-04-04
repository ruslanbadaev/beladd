import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:urban_control/cubit/navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:get/get.dart';

CSWidgetStyle brightnessStyle = const CSWidgetStyle(
    icon: const Icon(Icons.brightness_medium, color: Colors.black54));

class SettingsScreen extends StatelessWidget {
  SettingsScreen() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CubitBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return Container(
          child: CupertinoSettings(items: <Widget>[
        CSHeader('Размер текста'),
        CSSelection<int>(
          items: const <CSSelectionItem<int>>[
            CSSelectionItem<int>(text: 'Маленький', value: 0),
            CSSelectionItem<int>(text: 'Средний', value: 1),
            CSSelectionItem<int>(text: 'Большой', value: 2),
          ],
          onSelected: (index) {
            print(index);
          },
          currentSelection: 0,
        ),
        CSDescription(
          'Using Night mode extends battery life on devices with OLED display',
        ),
        const CSHeader(''),
        CSControl(
          nameWidget: Text('Loading...'),
          //contentWidget: CupertinoActivityIndicator(),
        ),
        CSButton(CSButtonType.DEFAULT, "Licenses", () {
          print("It works!");
        }),
        const CSHeader(''),
        CSButton(CSButtonType.DESTRUCTIVE, "Delete all data", () {})
      ]));
    }));
  }
}
