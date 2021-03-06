import 'package:flutter/material.dart';
import 'package:todolist/widget/bottom_navigation.dart';
import 'package:todolist/widget/fab.dart';

import 'package:todolist/utils/util.dart';

class Empty extends StatelessWidget {
  var bottomNavigationBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Hero(
                tag: 'Clipboard',
                child: Image.asset('assets/images/Clipboard-empty.png'),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Text(
                    'No tasks',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.TextHeader),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'You have no tasks to do.',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: CustomColors.TextBody,
                        fontFamily: 'opensans'),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
