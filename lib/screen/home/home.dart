import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/widget/app_bars.dart';
import 'package:todolist/widget/bottom_navigation.dart';
import 'package:todolist/widget/fab.dart';
import 'package:todolist/utils/util.dart';
import 'package:todolist/widget/slide_tile_widget.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final bottomNavigationBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView(
        padding: EdgeInsets.only(top: 16.0),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SlideTileWidget(
              title: '08.00 AM',
              subtitle: 'Send project ',
              iconslide: Image.asset('assets/images/trash.png'),
              isChecked: true,
              isBellActive: false,
              onTapSlide: () {}),
          SlideTileWidget(
              title: '08.00 AM',
              subtitle: 'Send project ',
              iconslide: Image.asset('assets/images/trash.png'),
              isChecked: true,
              isBellActive: false,
              onTapSlide: () {}),
        ],
      ),
    );
  }
}
