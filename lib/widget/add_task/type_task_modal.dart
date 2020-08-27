import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:todolist/utils/strings.dart';
import 'package:todolist/utils/util.dart';
import 'package:todolist/widget/pills_widget.dart';

class TypeTaskModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.only(left: 16.0, right: 16.0),
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
        itemBuilder: (_, index) {
          return PilssWidget(
            title: listTypeName()[index],
          );
        },
      ),
    );
  }

  UnmodifiableListView<String> listTypeName() => UnmodifiableListView([
        Strings.personal,
        Strings.work,
        Strings.meeting,
        Strings.shopping,
        Strings.shopping,
        Strings.party,
        Strings.study
      ]);
}
