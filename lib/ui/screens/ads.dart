import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:urban_control/controllers/cubit/ads.dart';
import 'package:urban_control/models/ad.dart';
import 'package:urban_control/ui/widgets/photo_slider.dart';
import 'package:polls/polls.dart';
import 'package:pagination/pagination.dart';

class AdsScreen extends StatelessWidget {
  final String text;

  AdsScreen({this.text}) : super();
  List test = [Colors.blue, Colors.green];

  @override
  Widget build(BuildContext context) {
    Future<List<Ad>> _itemLoader(contet, a) async {
      List data = await context
          .cubit<AdsCubit>()
          .getAds({'context': context, 'isReload': false});

      return data;
    }

    return Scaffold(
        body: CubitBuilder<AdsCubit, AdsState>(builder: (context, state) {
      return Container(
        child: PaginationList<Ad>(
          separatorWidget: Container(
            height: 0.5,
            color: Colors.black,
          ),
          itemBuilder: (BuildContext context, Ad item) {
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
                        child: Text(
                          '${item.title}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Container(
                        margin: EdgeInsets.only(
                            top: 4, bottom: 12, left: 24, right: 4),
                        child: Text(
                          '${item.text}',
                          style: TextStyle(),
                        )),
                    item.vote != null && item.vote['options'].length > 0
                        ? Polls(
                            children: [
                              for (Map option in item.vote['options'])
                                Polls.options(
                                    title: option['title'],
                                    value: option['value'])
/*                               Polls.options(title: 'Да', value: 8),
                              Polls.options(title: 'Нет', value: 3),
                              Polls.options(title: 'Наверное', value: 2),
                              Polls.options(title: 'Да нет наверное', value: 6), */
                            ],
                            question: Text(
                                /* 'Тестовый опрос' */ item.vote['question']),
                            currentUser: 'user',
                            creatorID: item.vote['creatorID'],
                            voteData: item.vote[
                                'voteData'] /* {'user2': 1, 'user1': 2} */,
                            userChoice: 2,
                            leadingPollStyle: TextStyle(color: Colors.white),
                            pollStyle: TextStyle(color: Colors.white),
                            outlineColor: Colors.blueGrey,
                            onVoteBackgroundColor:
                                Colors.blueGrey.withOpacity(.6),
                            leadingBackgroundColor:
                                Colors.blueAccent.withOpacity(.6),
                            backgroundColor: Colors.blueGrey,
                            onVote: (choice) {},
                          )
                        : Container(),
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
