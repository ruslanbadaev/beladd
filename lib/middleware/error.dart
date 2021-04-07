import 'dart:io';
import 'package:flutter/material.dart';
import 'package:customprompt/customprompt.dart';
import 'package:urban_control/middleware/storage.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class Error {
  Error();

  void checkConnection(context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
    } on SocketException catch (_) {
      CustomPrompt(
        color: Colors.blueGrey,
        animDuration: 500,
        title: 'Ошибка',
        type: Type.error,
        curve: Curves.easeInCubic,
        transparent: true,
        context: context,
        btnOneText: Text('Повторить'),
        content: 'Отсутствует интернет соединение',
        btnOneOnClick: () => checkConnection(context),
      ).alert();
    }
  }

  void checkRequestError(context, statusCode, repeatFunction, args) async {
    switch (statusCode) {
      case 401:
        CustomPrompt(
            color: Colors.blueGrey,
            animDuration: 200,
            title: 'Ошибка',
            type: Type.error,
            curve: Curves.easeInCubic,
            transparent: true,
            context: context,
            btnOneText: Text('Повторить'),
            btnTwoText: Text('Cancel'),
            content: 'Отсутствует интернет соединение',
            btnOneOnClick: () =>
                {Storage().set('token', null), Phoenix.rebirth(context)},
            btnTwoOnClick: () => {}).alert();
        break;
      case 422:
        CustomPrompt(
            color: Colors.blueGrey,
            animDuration: 300,
            title: 'Ошибка',
            type: Type.error,
            curve: Curves.linear,
            transparent: true,
            context: context,
            btnOneText: Text('Ок'),
            content: 'Ошибка запроса',
            btnOneOnClick: () => {},
            btnTwoOnClick: () => {}).alert();
        break;
      case 404:
        CustomPrompt(
            color: Colors.blueGrey,
            animDuration: 300,
            title: 'Ошибка',
            type: Type.error,
            curve: Curves.linear,
            transparent: true,
            context: context,
            btnOneText: Text('Ок'),
            content: 'Сервер не найден',
            btnOneOnClick: () => {}).alert();
        break;
      case 500:
        CustomPrompt(
          color: Colors.blueGrey,
          animDuration: 500,
          title: 'Ошибка',
          type: Type.error,
          curve: Curves.easeInCubic,
          transparent: true,
          context: context,
          btnOneText: Text('Повторить'),
          content: 'Ошибка соединения',
          btnOneOnClick: () => repeatFunction(args),
        ).alert();
        break;
      default:
        CustomPrompt(
          color: Colors.blueGrey,
          animDuration: 500,
          title: 'Неизвестная ошибка',
          type: Type.error,
          curve: Curves.easeInCubic,
          transparent: true,
          context: context,
          btnOneText: Text('Повторить'),
          content: 'Повторите попытку',
          btnOneOnClick: () => repeatFunction,
        ).alert();
    }
  }
}
