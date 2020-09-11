import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/navigator/navigator_bloc.dart';
import 'package:todolist/bloc/navigator/navigator_state.dart';
import 'package:todolist/screen/home/home.dart';
import 'package:todolist/screen/task/task_page.dart';
import 'package:todolist/widget/app_bars.dart';
import 'package:todolist/widget/bottom_navigation.dart';
import 'package:todolist/widget/fab.dart';
import 'package:todolist/widget/home/appbar_empty_widget.dart';
import 'package:todolist/widget/home/appbar_task_widget.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorBloc, NavigatorIndexState>(builder: (_, state) {
      return Scaffold(
        key: globalKey,
        appBar: AppBarEmptyWidget(), //AppBarTaskWidget(),
        body: SafeArea(child: _viewWidget[state.index]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: customFab(context, globalKey),
        bottomNavigationBar: BottomNavigationBarApp(context, state.index),
      );
    });
  }

  UnmodifiableListView<Widget> get _viewWidget {
    return UnmodifiableListView([Home(), TaskPage()]);
  }
}
