import 'package:cubit/cubit.dart';
import 'package:dio/dio.dart';
import 'package:urban_control/middleware/error.dart';
import 'package:urban_control/middleware/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_control/models/report.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:urban_control/controllers/profile.dart';
import 'package:get/get.dart' as getx;

class ReportsState {
  final List<Report> ads;
  final int index;
  ReportsState(this.ads, this.index);
}

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsState([], 1));
  Dio dio = new Dio();
  final ProfileController profileController = getx.Get.put(ProfileController());
  Future getAds(args) async {
    try {
      List<Report> ads = [];
      if (args['isReload']) {
        emit(ReportsState([], 1));
      }

      if (state.index != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString('token');
        dio.options.headers["authorization"] = "Bearer $token";

        Response response =
            await dio.get('$API_URL/reports/?page=${state.index}',
                options: Options(
                    followRedirects: false,
                    validateStatus: (status) {
                      return status < 500;
                    }));

        if (response.statusCode == 200 || response.statusCode == 201) {
          for (Map report in response.data['docs']) {
            ads.add(Report(
              id: report['_id'],
              title: report['title'],
              text: report['text'],
              creator: report['creator'],
              date: report['createdAt'],
              photos: report['files'],
            ));
          }

          emit(ReportsState(ads, response.data['nextPage']));
          return ads;
        } else
          Error().checkRequestError(
              args['context'],
              response.statusCode,
              getAds,
              {'context': args['context'], 'isReload': args['isReload']});

        return ads;
      } else
        return ads;
    } catch (e) {
      print('getAds error: $e');
      Error().checkConnection(args['context']);
      return state.ads;
    }
  }

  void removeReport(args) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      dio.options.headers["authorization"] = "Bearer $token";

      Response response = await dio.delete('$API_URL/reports/${args['id']}',
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showSuccess('Успех');
        EasyLoading.dismiss();
        Phoenix.rebirth(args['context']);
      } else
        EasyLoading.showError('Ошибка. Повторите запрос позже.');
      EasyLoading.dismiss();
    } catch (e) {
      print('removeReport error: $e');
      EasyLoading.showError('Ошибка. Повторите запрос позже.');
      EasyLoading.dismiss();
    }
  }

  void setClaim(args) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      dio.options.headers["authorization"] = "Bearer $token";
      Response response = await dio.post('$API_URL/reports/claim',
          data: {'creator': profileController.email, 'text': args['text']},
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showSuccess('Успех');
        EasyLoading.dismiss();
        Phoenix.rebirth(args['context']);
      } else
        EasyLoading.showError('Ошибка. Повторите запрос позже.');
      EasyLoading.dismiss();
    } catch (e) {
      print('setClaim error: $e');
      EasyLoading.showError('Ошибка. Повторите запрос позже.');
      EasyLoading.dismiss();
    }
  }
}
