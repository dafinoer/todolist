import 'package:flutter/material.dart';
import 'package:todolist/utils/strings.dart';
import 'package:todolist/widget/add_task/button_add.dart';
import 'package:todolist/widget/add_task/button_close_modal.dart';
import 'package:todolist/widget/add_task/date_task_modal.dart';
import 'package:todolist/widget/add_task/text_field_modal.dart';
import 'package:todolist/widget/add_task/type_task_modal.dart';

class Modal {
  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height - 100,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0)),
              color: Colors.white),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(175, 30),
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ButtonCloseModal(),
                    const Text(
                      Strings.add_new_task,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
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
                    ButtonAdd(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
