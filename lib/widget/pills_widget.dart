import 'package:flutter/material.dart';
import 'package:todolist/utils/util.dart';

class PilssWidget extends StatelessWidget {
  final String title;

  const PilssWidget({this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Container(
            height: 10.0,
            width: 10.0,
            margin: EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: CustomColors.PurpleIcon,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(title),
          ),
        ],
      ),
    );
  }
}
