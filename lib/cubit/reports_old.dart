import 'package:cubit/cubit.dart';
import 'package:dio/dio.dart';
import 'package:urban_control/middleware/error.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_control/models/report.dart';

class ReportsListState {
  final List<Report> reports;
  final int index;
  ReportsListState(this.reports, this.index);
}

class ReportsListCubit extends Cubit<ReportsListState> {
  ReportsListCubit() : super(ReportsListState([], 0));
  Dio dio = new Dio();

  Future getReports(args) async {
    try {
      List<Report> reports = [];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      dio.options.headers["authorization"] = "Bearer $token";
      Response response = await dio.get('http://134.0.117.33:3000/reports',
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        for (Map report in response.data['docs']) {
          reports.add(Report(
            title: report['title'],
            text: report['text'],
            creator: report['creator'],
            date: report['updatedAt'],
            photos: report['files'],
          ));
        }

        emit(ReportsListState(reports, state.index));
        return true;
      } else
        Error().checkRequestError(args['context'], response.statusCode,
            getReports, {'context': args['context']});
      return false;
    } catch (e) {
      print(e);
      Error().checkConnection(args['context']);
      return false;
    }
  }

  Future setPoll(args) async {}
}
