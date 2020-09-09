import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:todolist/bloc/add/add_bloc.dart';
import 'package:todolist/bloc/add/add_state.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/utils/util.dart';
import 'package:todolist/widget/add_task/button_add.dart';
import 'package:todolist/widget/add_task/button_notif.dart';
import 'package:todolist/widget/add_task/main_task.dart';
import 'package:todolist/widget/app_bars.dart';

class EditDetailPage extends StatefulWidget {
  final Task task;

  final String docId;

  EditDetailPage(@required this.task, @required this.docId)
      : assert(task != null && docId != null);

  @override
  _EditDetailPageState createState() => _EditDetailPageState();
}

class _EditDetailPageState extends State<EditDetailPage> {
  Task _taskItem;

  @override
  void initState() {
    _taskItem = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddBloc(
          TodoState(
            title: _taskItem.title,
            type: _taskItem.typeTask,
            dateTime: DateTime.fromMillisecondsSinceEpoch(_taskItem.schedule),
            isChecked: _taskItem.isChecked,
            isNotif: _taskItem.isNotif
          ),
          isEdit: true),
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75.0),
            child: GradientAppBar(
              flexibleSpace: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomPaint(
                    painter: CircleOne(),
                  ),
                  CustomPaint(
                    painter: CircleTwo(),
                  ),
                ],
              ),
              title: Container(child: const Text('Edit Detail')),
              elevation: 0,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  CustomColors.HeaderBlueDark,
                  CustomColors.HeaderBlueLight
                ],
              ),
              actions: [ButtonNotif()],
            ),
          ),
          body: SafeArea(
            child: BlocListener<AddBloc, AddState>(
              listener: (_, state) {
                if (state is SubmitLoading && state.isLoading) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                }
              },
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          child: MainTask(
                    isEdit: true,
                  ))),
                  ButtonAdd(
                    isEdit: true,
                    docId: widget.docId,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
