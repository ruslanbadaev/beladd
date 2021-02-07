import 'package:cubit/cubit.dart';
import 'package:dio/dio.dart';
import 'package:beladd/middleware/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:beladd/cubit/navigation_cubit.dart';

class AuthState {
  final bool isAuth;
  final String token;
  AuthState(this.isAuth, this.token);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(true, null));
  Dio dio = new Dio();

  setToStorage(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  void login(context, email, password) async {
    try {
      Response response = await dio.post('$API_URL:$API_PORT/login',
          data: {'email': email, 'password': password});
      print(response.data['token']);
      setToStorage('token', response.data['token']);
      setToStorage('name', response.data['name']);
      setToStorage('role', response.data['role']);
      setToStorage('id', response.data['_id']);
      emit(AuthState(true, response.data['token']));
      print('***');
      //context.cubit<NavigationCubit>().setAuth(1, true);
    } catch (e) {
      print(e);
      emit(AuthState(false, state.token));
    }
  }

  void register(name, email, password) async {
    try {
      Response response = await dio.post('$API_URL:$API_PORT/register',
          data: {name: name, email: email, password: password});
      print(response);
    } catch (e) {
      print(e);
      emit(AuthState(true, state.token));
    }
  }

  Future<bool> start() async {
    return false;
  }
}
