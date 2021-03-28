import 'package:beladd/cubit/map.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:beladd/cubit/report.dart';
import 'package:beladd/cubit/reports.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:image_picker/image_picker.dart';

class MapScreen extends StatelessWidget {
  final String text;
  final picker = ImagePicker();
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(36.0),
    topRight: Radius.circular(36.0),
  );
  MapScreen({this.text}) : super();

  @override
  Widget build(BuildContext context) {
    TextEditingController descriptionController = TextEditingController();

    return CubitBuilder<MapCubit, MapState>(builder: (mapContext, mapState) {
      return CubitBuilder<ReportsListCubit, ReportsListState>(
          builder: (reportsListContext, reportsListState) {
        return Scaffold(
          body: SlidingUpPanel(
              maxHeight: MediaQuery.of(context).size.height * .7,
              minHeight: mapState.creationMode ? 36 : 0,
              borderRadius: radius,
              panel: Container(
                  height: 200,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_upward_rounded),
                              // Text('- - -')
                            ]),
                        Text('Создание жалобы',
                            style: TextStyle(fontSize: 36),
                            textAlign: TextAlign.center),
                        Text('Данное рекламное сооружение',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.start),
                        CupertinoRadioChoice(
                            selectedColor: Colors.orangeAccent,
                            choices: {
                              'illegal': 'Нелегальное',
                              'decrepit': 'Ветхое'
                            },
                            onChange: (selected) {
                              context.cubit<ReportCubit>().setType(selected);
                            },
                            initialKeyValue: 'illegal'),
                        Container(
                            margin: EdgeInsets.all(12),
                            child: TextField(
                                cursorColor: Colors.blueGrey,
                                controller: descriptionController,
                                keyboardType: TextInputType.text,
                                maxLines: 3,
                                decoration: InputDecoration(
                                    fillColor: Colors.blueGrey,
                                    focusColor: Colors.blueGrey,
                                    hoverColor: Colors.blueGrey,
                                    prefixIcon: Icon(Icons.description_rounded),
                                    border: OutlineInputBorder(),
                                    labelText: "Введите описание"))),
                        Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width * .9,
                            child: CubitBuilder<ReportCubit, ReportState>(
                                builder: (reportContext, reportState) {
                              return ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    if (reportState.images.length <= 4)
                                      InkWell(
                                          onTap: () => {
                                                context
                                                    .cubit<ReportCubit>()
                                                    .addPhoto()
                                              },
                                          child: Row(children: [
                                            Icon(
                                              Icons.add_a_photo_rounded,
                                              size: 42,
                                              color: Colors.blueGrey,
                                            ),
                                            if (reportState.images.length == 0)
                                              Text('  Добавить фото'),
                                          ])),
                                    for (var item in reportState.images)
                                      Container(
                                          margin: EdgeInsets.only(left: 12),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(40))),
                                          width: 60,
                                          height: 60,
                                          child: InkWell(
                                              onTap: () => context
                                                  .cubit<ReportCubit>()
                                                  .removePhoto(item),
                                              child: Image.file(
                                                item,
                                                fit: BoxFit.cover,
                                              )))
                                  ]);
                            })),
                        SizedBox(height: 64)
                      ])),
              body: new FlutterMap(
                options: new MapOptions(
                    center: new LatLng(44.771195541051824, 39.86906043950081),
                    zoom: 13.0,
                    onTap: (area) => {},
                    onLongPress: (point) => {
                          context.cubit<MapCubit>().setMarker(point),
                          context.cubit<ReportCubit>().setLatLong(point),
                          context.cubit<ReportCubit>()
                        }),
                layers: [
                  new TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']),
                  new MarkerLayerOptions(
                    markers: mapState.markers,
                  ),
                ],
              )),
          floatingActionButton: mapState.creationMode
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.blueGrey,
                      child: Icon(Icons.check_rounded),
                      onPressed: () => {
                        context.cubit<ReportCubit>().sendReport({
                          'context': context,
                          'description': descriptionController.text
                        }),
                        context.cubit<MapCubit>().removeMarker()
                      },
                    ),
                    SizedBox(width: 8),
                    FloatingActionButton(
                      backgroundColor: Colors.orangeAccent,
                      child: Icon(Icons.close_rounded),
                      onPressed: () =>
                          {context.cubit<MapCubit>().removeMarker()},
                    )
                  ],
                )
              : Container(),
        );
      });
    });
  }
}
