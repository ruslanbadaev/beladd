import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:urban_control/cubit/reports.dart';
import 'package:urban_control/models/report.dart';
import 'package:urban_control/ui/widgets/photo_slider.dart';
import 'package:polls/polls.dart';
import 'package:pagination/pagination.dart';
import 'package:get/get.dart';
import 'package:urban_control/controllers/profile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ndialog/ndialog.dart';

class ReportsScreen extends StatelessWidget {
  final String text;
  final ProfileController profileController = Get.put(ProfileController());
  ReportsScreen({this.text}) : super();
  List test = [Colors.blue, Colors.green];
  TextEditingController claimController = TextEditingController();

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
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: Container(
                color: Colors.white,
                child: ListTile(
                  minLeadingWidth: 0,
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
                                          Text(
                                              'Нелегальное рекламное сооружение'),
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
                            alignment: Alignment.centerRight,
                            margin:
                                EdgeInsets.only(top: 12, bottom: 12, right: 48),
                            child: Text(
                              '${item.date.replaceAll('T', ' ').split(':')[0]}:${item.date.split(':')[1]}',
                              style: TextStyle(
                                color: Colors.blueGrey[300],
                              ),
                            )),
                      ]),
                ),
              ),
/*               actions: <Widget>[
                IconSlideAction(
                  caption: 'Жалоба',
                  color: Colors.blue,
                  icon: Icons.archive,
                  onTap: () => {},
                ),
              ], */
              secondaryActions: <Widget>[
                profileController.name == item.creator
                    ? IconSlideAction(
                        caption: 'Удалить',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () => {
                          context.cubit<ReportsCubit>().removeReport(
                              {'context': context, 'id': item.id}),
                        },
                      )
                    : IconSlideAction(
                        caption: 'Жалоба',
                        color: Colors.black45,
                        icon: Icons.more_horiz,
                        onTap: () => {
                          DialogBackground(
                            dialog: AlertDialog(
                                backgroundColor: Colors.white.withOpacity(1),
                                title: Container(
                                    width: 380,
                                    child: TextField(
                                        cursorColor: Colors.blueGrey,
                                        controller: claimController,
                                        keyboardType: TextInputType.text,
                                        maxLines: 3,
                                        decoration: InputDecoration(
                                            fillColor: Colors.blueGrey,
                                            focusColor: Colors.blueGrey,
                                            hoverColor: Colors.blueGrey,
                                            prefixIcon:
                                                Icon(Icons.description_rounded),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(12.0),
                                              ),
                                            ),
                                            labelText: "Введите жалобу"))),
                                content: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  padding: EdgeInsets.all(24),
                                  child: RaisedButton(
                                    color: Colors.blueGrey.withOpacity(.6),
                                    onPressed: () {
                                      context.cubit<ReportsCubit>().setClaim({
                                        'contxt': context,
                                        'text': claimController.text
                                      });
                                    },
                                    shape: RoundedRectangleBorder(

                                        //claimController
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(
                                      'Отправить',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )),
                          ).show(context)
                        }, //setClaim
                      ),
              ],
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
