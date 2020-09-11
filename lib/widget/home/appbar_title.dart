import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/schedule/bloc.dart';
import 'package:todolist/bloc/schedule/schedule_bloc.dart';

class AppBarTitle extends StatelessWidget {
  final username;

  AppBarTitle({this.username}) : assert(username != null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(buildWhen: (prev, cur) {
      if (prev is ScheduleTask && cur is ScheduleTask) {
        return prev.totalTask != cur.totalTask;
      }
    }, builder: (_, state) {
      int total = 0;

      if (state is ScheduleTask) {
        total = state.totalTask;
      }
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              username,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              total > 0
                  ? 'Today you have $total tasks'
                  : 'Today you have no tasks',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      );
    });
  }
}
