import 'package:cubit/cubit.dart';
import 'package:dio/dio.dart';
import 'package:urban_control/middleware/error.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:latlong/latlong.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ReportState {
  final List<File> images;
  final String token;
  final String adress;
  final LatLng latLong;
  final String type;

  final int tab;
  ReportState(
      this.images, this.token, this.adress, this.tab, this.latLong, this.type);
}

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportState([], null, '', 1, LatLng(0, 0), 'illegal'));
  Dio dio = new Dio();

  // context, description
  Future sendReport(args) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      String creator = prefs.getString('name');
      if (token == null) Phoenix.rebirth(args['context']);
      print({
        'title': state.type ?? 'illegal',
        'text': args['description'].toString(),
        'creator': creator ?? 'Аноним',
        'longitude': state.latLong.longitude.toString(),
        'latitude': state.latLong.latitude.toString()
      });
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://134.0.117.33:3000/reports'));
      request.fields.addAll({
        'title': state.type,
        'text': args['description'].toString(),
        'creator': creator ?? 'Аноним',
        'longitude': state.latLong.longitude.toString(),
        'latitude': state.latLong.latitude.toString()
      });

      for (File file in state.images)
        request.files.add(await http.MultipartFile.fromPath('', file.path));

      request.headers.addAll(headers);
      EasyLoading.show(status: 'Отправка...');
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showSuccess('Успех');
        EasyLoading.dismiss();
        Phoenix.rebirth(args['context']);
        print(await response.stream.bytesToString());
      } else {
        EasyLoading.showError('Ошибка. Повторите запрос позже.');
        EasyLoading.dismiss();
        print('1::: ${response.reasonPhrase}');
      }
    } catch (e) {
      EasyLoading.showError('Ошибка. Повторите запрос позже.');
      EasyLoading.dismiss();
      Error().checkConnection(args['context']);
      print('2::: $e');

      emit(ReportState(state.images, state.token, state.adress, state.tab,
          state.latLong, state.type));
      return false;
    }
  }

  void addPhoto() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      List<File> images = state.images;
      if (pickedFile != null) {
        images.add(File(pickedFile.path));
      } else {
        print('Фото не выбрано');
      }

      emit(ReportState(images, state.token, state.adress, state.tab,
          state.latLong, state.type));
    } catch (e) {
      print(e);
    }
  }

  void setLatLong(latLong) => emit(ReportState(
      state.images, state.token, state.adress, state.tab, latLong, state.type));
  void setType(type) => emit(ReportState(
      state.images, state.token, state.adress, state.tab, state.latLong, type));

  void removePhoto(image) async {
    try {
      List<File> images = state.images;
      images.remove(image);
      emit(ReportState(images, state.token, state.adress, state.tab,
          state.latLong, state.type));
    } catch (e) {
      print(e);
    }
  }
}
