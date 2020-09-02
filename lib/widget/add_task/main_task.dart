import 'package:flutter/material.dart';
import 'package:todolist/utils/strings.dart';
import 'package:todolist/widget/add_task/button_add.dart';
import 'package:todolist/widget/add_task/button_close_modal.dart';
import 'package:todolist/widget/add_task/date_task_modal.dart';
import 'package:todolist/widget/add_task/text_field_modal.dart';
import 'package:todolist/widget/add_task/type_task_modal.dart';

class MainTask extends StatelessWidget {

  final bool isEdit;

  MainTask({this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          isEdit ? const SizedBox() : ButtonCloseModal(),
          isEdit ? const SizedBox() : Text(
            Strings.add_new_task,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          TextFieldModal(),
          TypeTaskModal(),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 20.0, left: 16.0),
            child: const Text(
              'Choose date',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: 10.0, left: 16.0, right: 16.0, bottom: 16.0),
              child: DateTaskModal()),
          isEdit ? const SizedBox() : ButtonAdd(),
        ],
      ),
    );
  }
}
