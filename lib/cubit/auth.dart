import 'package:cubit/cubit.dart';
import 'package:dio/dio.dart';
import 'package:urban_control/middleware/error.dart';
import 'package:urban_control/middleware/storage.dart';
import 'package:urban_control/middleware/constants.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class AuthState {
  final bool isAuth;
  final String token;
  final int tab;
  AuthState(this.isAuth, this.token, this.tab);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(true, null, 1));
  Dio dio = new Dio();
  // context, email, password
  Future login(args) async {
    try {
      Response response = await dio.post(
        '$API_URL:$API_PORT/login',
        data: {'email': args['email'], 'password': args['password']},
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Storage().set('token', response.data['token']);
        Storage().set('name', response.data['name']);
        Storage().set('role', response.data['role']);
        Storage().set('id', response.data['_id']);
        emit(AuthState(true, response.data['token'], state.tab));
        Phoenix.rebirth(args['context']);
        return true;
      } else
        Error().checkRequestError(args['context'], response.statusCode, login, {
          'context': args['context'],
          'email': args['email'],
          'password': args['password']
        });
      print('---');
      return false;
    } catch (e) {
      print('\\\\');
      Error().checkConnection(args['context']);
      emit(AuthState(false, state.token, state.tab));
      return false;
    }
  }

  // context, name, email, password
  Future register(args) async {
    try {
      Response response = await dio.post(
        '$API_URL:$API_PORT/register',
        data: {
          'name': args['name'],
          'email': args['email'],
          'password': args['password']
        },
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Storage().set('token', response.data['token']);
        Storage().set('name', response.data['name']);
        Storage().set('role', response.data['role']);
        Storage().set('id', response.data['_id']);
        emit(AuthState(true, response.data['token'], state.tab));
        print('***');
        Phoenix.rebirth(args['context']);
        return true;
      } else
        Error()
            .checkRequestError(args['context'], response.statusCode, register, {
          'context': args['context'],
          'name': args['name'],
          'email': args['email'],
          'password': args['password']
        });
      return false;
    } catch (e) {
      print(e);
      Error().checkConnection(args['context']);
      emit(AuthState(false, state.token, state.tab));
      return false;
    }
  }

  void changeTab(index) => emit(AuthState(state.isAuth, state.token, index));

  Future<bool> start() async {
    return false;
  }
}
