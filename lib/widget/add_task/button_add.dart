import 'package:flutter/material.dart';
import 'package:todolist/bloc/add/add_bloc.dart';
import 'package:todolist/bloc/add/add_event.dart';
import 'package:todolist/bloc/add/add_state.dart';
import 'package:todolist/utils/strings.dart';
import 'package:todolist/utils/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/widget/add_task/builder_helper.dart';

class ButtonAdd extends StatelessWidget implements BaseBuilder {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddBloc, AddState>(
        buildWhen: refreshWidget,
        builder: (_, state) {
          bool isLoading = false;

          if (state is TodoState) {
            isLoading = state.isLoading;
          }

          return RaisedButton(
            onPressed: () => context.bloc<AddBloc>().add(SubmitEvent()),
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 60,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    CustomColors.BlueLight,
                    CustomColors.BlueDark,
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.BlueShadow,
                    blurRadius: 2.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Center(
                child: isLoading
                    ? CircularProgressIndicator()
                    : const Text(
                        Strings.add_task,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
              ),
            ),
          );
        });
  }

  @override
  bool refreshWidget(AddState prev, AddState curr) {
    if (prev is TodoState && curr is TodoState) {
      if (prev.isLoading != curr.isLoading) return true;
      return false;
    } else {
      return false;
    }
  }
}
