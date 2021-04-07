import 'package:get/get.dart';
import 'package:urban_control/middleware/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ProfileController profileController = Get.put(ProfileController());

class ProfileController extends GetxController {
  SharedPreferences prefs;
  var name = 'Аноним';
  var email = '';
  var id = '';
  getName() async => name = (await Storage().getString('name'));
  getEmail() async => email = (await Storage().getString('email'));
  getId() async => id = (await Storage().getString('id'));
}
