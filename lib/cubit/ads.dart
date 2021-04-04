import 'package:cubit/cubit.dart';
import 'package:dio/dio.dart';
import 'package:urban_control/middleware/error.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_control/models/ad.dart';

class AdsState {
  final List<Ad> ads;
  final int index;
  AdsState(this.ads, this.index);
}

class AdsCubit extends Cubit<AdsState> {
  AdsCubit() : super(AdsState([], 1));
  Dio dio = new Dio();

  Future getAds(args) async {
    try {
      List<Ad> ads = [];
      if (args['isReload']) {
        emit(AdsState([], 1));
      }

      if (state.index != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString('token');
        dio.options.headers["authorization"] = "Bearer $token";

        Response response =
            await dio.get('http://134.0.117.33:3000/ads/?page=${state.index}',
                options: Options(
                    followRedirects: false,
                    validateStatus: (status) {
                      return status < 500;
                    }));

        if (response.statusCode == 200 || response.statusCode == 201) {
          for (Map report in response.data['docs']) {
            ads.add(Ad(
              id: report['_id'],
              title: report['title'],
              text: report['text'],
              creator: report['creator'],
              date: report['createdAt'],
              photos: report['files'],
            ));
          }

          emit(AdsState(ads, response.data['nextPage']));
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
      print(e);
      Error().checkConnection(args['context']);
      return state.ads;
    }
  }
}
