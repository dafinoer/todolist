import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/add/add_bloc.dart';
import 'package:todolist/bloc/add/add_state.dart';
import 'package:todolist/bloc/add/bloc.dart';
import 'package:todolist/utils/strings.dart';
import 'package:todolist/utils/util.dart';
import 'package:todolist/widget/add_task/builder_helper.dart';
import 'package:todolist/widget/pills_widget.dart';

class TypeTaskModal extends StatelessWidget implements BaseBuilder {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddBloc, AddState>(
        buildWhen: (prev, cur) => refreshWidget(prev, cur),
        builder: (_, state) {
          String choiceType;

          if (state is TodoState) {
            choiceType = state.type;
          }

          return Container(
            width: double.infinity,
            height: 60,
            margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: CustomColors.GreyBorder,
                ),
                bottom: BorderSide(
                  width: 1.0,
                  color: CustomColors.GreyBorder,
                ),
              ),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: listTypeName().length,
              itemBuilder: (_, index) {
                if (choiceType != null &&
                    listTypeName()[index].contains(choiceType)) {
                  return PilssWidget(
                    title: listTypeName()[index],
                    isSelect: true,
                    ontap: () {
                      context
                          .bloc<AddBloc>()
                          .add(TypeChoice(listTypeName()[index]));
                    },
                  );
                }

                return PilssWidget(
                  title: listTypeName()[index],
                  ontap: () {
                    context
                        .bloc<AddBloc>()
                        .add(TypeChoice(listTypeName()[index]));
                  },
                );
              },
            ),
          );
        });
  }

  UnmodifiableListView<String> listTypeName() => UnmodifiableListView([
        Strings.personal,
        Strings.work,
        Strings.meeting,
        Strings.shopping,
        Strings.party,
        Strings.study
      ]);

  @override
  bool refreshWidget(AddState prev, AddState curr) {
    if (prev is TodoState && curr is TodoState) {
      if (prev.type != curr.type) return true;

      return false;
    }
    return false;
  }
}
