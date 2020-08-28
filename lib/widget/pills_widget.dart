import 'package:flutter/material.dart';
import 'package:todolist/utils/strings.dart';
import 'package:todolist/utils/util.dart';

class PilssWidget extends StatelessWidget {
  final String title;
  final Function ontap;

  final bool isSelect;

  const PilssWidget({this.title, this.ontap, this.isSelect = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: isSelect
              ? BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  color: CustomColors.GreenIcon,
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.GreenShadow,
                      blurRadius: 5.0,
                      spreadRadius: 3.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ],
                )
              : BoxDecoration(),
          child: Row(
            children: <Widget>[
              Container(
                height: 10.0,
                width: 10.0,
                margin: EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  color: _colorsByStatus(title),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(title),
              ),
            ],
          ),
        ),
      ),
      onTap: ontap,
    );
  }

  Color _colorsByStatus(String name) {
    if (name.contains(Strings.work)) {
      return CustomColors.GreenIcon;
    } else if (name.contains(Strings.meeting)) {
      return CustomColors.PurpleIcon;
    } else if (name.contains(Strings.study)) {
      return CustomColors.BlueIcon;
    } else if (name.contains(Strings.shopping)) {
      return CustomColors.OrangeIcon;
    } else if (name.contains(Strings.personal)) {
      return CustomColors.YellowAccent;
    }
    return Colors.grey[400];
  }
}
