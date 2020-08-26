import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/navigator/navigator_bloc.dart';
import 'package:todolist/bloc/navigator/navigator_state.dart';
import 'package:todolist/screen/home/home.dart';
import 'package:todolist/screen/task/task.dart';
import 'package:todolist/widget/app_bars.dart';
import 'package:todolist/widget/bottom_navigation.dart';
import 'package:todolist/widget/fab.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBloc, NavigatorIndexState>(builder: (_, state) {
      return Scaffold(
        appBar: emptyAppbar(),
        body: _viewWidget[state.index],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: customFab(context),
        bottomNavigationBar: BottomNavigationBarApp(context, state.index),
      );
    });
  }

  UnmodifiableListView<Widget> get _viewWidget {
    return UnmodifiableListView([Home(), Task()]);
  }
}
