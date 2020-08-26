import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/navigator/bloc.dart';
import 'package:todolist/bloc/navigator/navigator_bloc.dart';

import 'package:todolist/utils/util.dart';

class BottomNavigationBarApp extends StatelessWidget {
  final int bottomNavigationBarIndex;
  final BuildContext context;

  const BottomNavigationBarApp(this.context, this.bottomNavigationBarIndex);

  void onTabTapped(int index) {
    if (index == 0) {
      context.bloc<NavigatorBloc>().add(NavigationType.HOME);
    } else {
      context.bloc<NavigatorBloc>().add(NavigationType.TASK);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: bottomNavigationBarIndex,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 10,
      selectedLabelStyle: TextStyle(color: CustomColors.BlueDark),
      selectedItemColor: CustomColors.BlueDark,
      unselectedFontSize: 10,
      items: [
        BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Image.asset(
              'assets/images/home.png',
              color: (bottomNavigationBarIndex == 0)
                  ? CustomColors.BlueDark
                  : CustomColors.TextGrey,
            ),
          ),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Image.asset(
              'assets/images/task.png',
              color: (bottomNavigationBarIndex == 1)
                  ? CustomColors.BlueDark
                  : CustomColors.TextGrey,
            ),
          ),
          title: Text('Task'),
        ),
      ],
      onTap: onTabTapped,
    );
  }
}
