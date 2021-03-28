import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage();

  set(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
