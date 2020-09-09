import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/add/add_bloc.dart';
import 'package:todolist/bloc/add/bloc.dart';
import 'package:todolist/widget/add_task/main_task.dart';

class Modal {
  GlobalKey<ScaffoldState> key;

  Modal(this.key);

  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocProvider(
            create: (_) => AddBloc(TodoState()),
            child: BlocListener<AddBloc, AddState>(
              listener: (_, state) {
                if (state is SubmitLoading && state.isLoading) {
                  Navigator.pop(context);
                } else if (state is AddError) {
                  final snackbar = SnackBar(content: Text(state.error));
                  key.currentState.showSnackBar(snackbar);
                }
              },
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0)),
                      color: Colors.white),
                  child: SingleChildScrollView(
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
                        MainTask()
                      ],
                    ),
                  )),
            ));
      },
    );
  }
}
