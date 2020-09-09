import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/add/add_bloc.dart';
import 'package:todolist/bloc/add/add_state.dart';
import 'package:todolist/bloc/add/bloc.dart';
import 'package:todolist/widget/add_task/builder_helper.dart';

class ButtonNotif extends StatelessWidget implements BaseBuilder {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddBloc, AddState>(
        buildWhen: refreshWidget,
        builder: (_, state) {
          bool isChecked = false;

          if (state is TodoState) {
            isChecked = state.isNotif;
          }

          return IconButton(
              icon: Icon(
                  isChecked ? Icons.notifications : Icons.notifications_none),
              onPressed: () {
                context.bloc<AddBloc>().add(NotifStatusEvent(!isChecked));
              });
        });
  }

  @override
  bool refreshWidget(AddState prev, AddState curr) {
    if (prev is TodoState && curr is TodoState) {
      return prev.isNotif != curr.isNotif;
    }
    return false;
  }
}
