import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:beladd/cubit/navigation_cubit.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:polls/polls.dart';

class NewsScreen extends StatelessWidget {
  final String text;

  List<String> hardcodeImages = [
    'https://avatars.mds.yandex.net/get-zen_doc/1661842/pub_5dda8a6659178a1f5db6c1d5_5dda8b773efb4d2736dc382a/scale_1200',
    'https://149363556.v2.pressablecdn.com/wp-content/uploads/2019/04/Tallinn_Die_Kulturha_25788997.jpg',
    'https://favera.ru/img/2017/01/19/1441418_1484838060.jpg',
    'https://cdn.pixabay.com/photo/2018/11/25/14/27/estonia-3837540_1280.jpg'
  ];
  List<String> listOfUrls = [
    "https://cosmosmagazine.com/wp-content/uploads/2020/02/191010_nature.jpg",
    "https://scx2.b-cdn.net/gfx/news/hires/2019/2-nature.jpg",
    "https://isha.sadhguru.org/blog/wp-content/uploads/2016/05/natures-temples.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/7/77/Big_Nature_%28155420955%29.jpeg",
    "https://s23574.pcdn.co/wp-content/uploads/Singular-1140x703.jpg",
    "https://www.expatica.com/app/uploads/sites/9/2017/06/Lake-Oeschinen-1200x675.jpg",
  ];

  NewsScreen({this.text}) : super();
  List test = [Colors.blue, Colors.green];
  double option1 = 2.0;
  double option2 = 0.0;
  double option3 = 2.0;
  double option4 = 3.0;

  String user = "test@mail.com";
  Map usersWhoVoted = {
    'sam@mail.com': 3,
    'mike@mail.com': 4,
    'john@mail.com': 1,
    'kenny@mail.com': 1
  };
  String creator = "eddy@mail.com";
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CubitBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return Container(
        child: TikTokStyleFullPageScroller(
          contentSize: test.length,
          swipeThreshold: .1,
          swipeVelocityThreshold: 1000,
          animationDuration: const Duration(milliseconds: 500),
          builder: (BuildContext context, int index) {
            return Container(
                //color: test[index],
                child: Column(children: [
              Polls(
                children: [
                  Polls.options(title: 'Да', value: option1),
                  Polls.options(title: 'Нет', value: option2),
                  Polls.options(title: 'Наверное', value: option3),
                  Polls.options(title: 'Да нет, наверное', value: option4),
                ],
                question: Text('Оставить ли опрос?'),
                currentUser: this.user,
                creatorID: this.creator,
                voteData: usersWhoVoted,
                userChoice: usersWhoVoted[this.user],
                onVoteBackgroundColor: Colors.blue,
                leadingBackgroundColor: Colors.blue,
                backgroundColor: Colors.white,
                onVote: (choice) {
                  print(choice);
                },
              )
            ]));
          },
        ),
      );
    }));
  }
}
