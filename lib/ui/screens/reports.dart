import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:urban_control/cubit/reports.dart';
import 'package:urban_control/models/report.dart';
import 'package:urban_control/ui/widgets/photo_slider.dart';
import 'package:polls/polls.dart';
import 'package:pagination/pagination.dart';

class ReportsScreen extends StatelessWidget {
  final String text;

  ReportsScreen({this.text}) : super();
  List test = [Colors.blue, Colors.green];

  @override
  Widget build(BuildContext context) {
    Future<List<Report>> _itemLoader(contet, a) async {
      List data = await context
          .cubit<ReportsCubit>()
          .getAds({'contxt': context, 'isReload': false});

      return data;
    }

    return Scaffold(body:
        CubitBuilder<ReportsCubit, ReportsState>(builder: (context, state) {
      return Container(
        child: PaginationList<Report>(
          separatorWidget: Container(
            height: 0.5,
            color: Colors.black,
          ),
          itemBuilder: (BuildContext context, Report item) {
            return ListTile(
              title: item.photos.length > 0
                  ? Container(
                      margin: EdgeInsets.only(top: 16),
                      child: PhotoSlider(
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          photos: item.photos))
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Icon(
                        Icons.no_photography_rounded,
                        size: 128,
                        color: Colors.grey,
                      )),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            top: 24, bottom: 4, left: 24, right: 8),
                        child: item.title == 'legal'
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.place_rounded,
                                    color: Colors.blue,
                                  ),
                                  Text('Легальное рекламное сооружение'),
                                ],
                              )
                            : item.title == 'illegal'
                                ? Row(
                                    children: [
                                      Icon(
                                        Icons.place_rounded,
                                        color: Colors.red,
                                      ),
                                      Text('Нелегальное рекламное сооружение'),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Icon(
                                        Icons.place_rounded,
                                        color: Colors.orange,
                                      ),
                                      Text('Ветхое рекламное сооружение'),
                                    ],
                                  ) /* Text(
                          '${item.title}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ) */
                        ),
                    Container(
                        margin: EdgeInsets.only(
                            top: 4, bottom: 12, left: 24, right: 4),
                        child: Text(
                          '${item.text}',
                          style: TextStyle(),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 12, bottom: 12, left: 48),
                        child: Text(
                          '${item.date.replaceAll('T', ' ').split(':')[0]}:${item.date.split(':')[1]}',
                          style: TextStyle(color: Colors.blueGrey[300]),
                        )),
                  ]),
            );
          },
          pageFetch: (a) => _itemLoader(context, a),
          onError: (dynamic error) => Center(
            child: Text('Something Went Wrong'),
          ),
          onEmpty: Center(
            child: Text('Список пуст'),
          ),
        ),
      );
    }));
  }
}
