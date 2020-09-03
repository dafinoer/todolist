import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/task/task_bloc.dart';
import 'package:todolist/bloc/task/task_state.dart';
import 'package:todolist/widget/app_bars.dart';
import 'package:todolist/widget/task/items_list.dart';

class TaskListPage extends StatefulWidget {
  final String typePage;

  TaskListPage(this.typePage);

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  String typeCollection;

  @override
  void initState() {
    typeCollection = widget.typePage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppbar(),
      body: BlocProvider(
        create: (_) => TaskBloc(TaskLoading(), typeCollection.toLowerCase()),
        child: ItemList(),
      ),
    );
  }
}
