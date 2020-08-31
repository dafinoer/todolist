import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/utils/util.dart';

class SlideTileWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget iconslide;
  final bool isChecked;
  final bool isBellActive;
  final Function onTapSlide;
  final bool isMarginTop;
  final Function onTapCheck;

  SlideTileWidget(
      {this.title,
      this.isMarginTop = false,
      this.subtitle,
      this.iconslide,
      this.isChecked = false,
      this.isBellActive = false,
      this.onTapCheck,
      this.onTapSlide});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
        padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Image.asset('assets/images/checked-empty.png'),
              InkWell(
                onTap: onTapCheck,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: isChecked
                      ? Image.asset('assets/images/checked.png')
                      : Image.asset('assets/images/checked-empty.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  title ?? '',
                  style: TextStyle(color: CustomColors.TextGrey),
                ),
              ),
              Expanded(
                child: Text(
                  subtitle ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: isChecked
                      ? TextStyle(
                          color: CustomColors.TextGrey,
                          decoration: TextDecoration.lineThrough)
                      : TextStyle(
                          color: CustomColors.TextHeader,
                          fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: isBellActive
                    ? Image.asset('assets/images/bell-small-yellow.png')
                    : Image.asset('assets/images/bell-small.png'),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [0.015, 0.015],
            colors: [CustomColors.GreenIcon, Colors.white],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(
              color: CustomColors.GreyBorder,
              blurRadius: 10.0,
              spreadRadius: 5.0,
              offset: Offset(0.0, 0.0),
            ),
          ],
        ),
      ),
      secondaryActions: <Widget>[
        SlideAction(
          child: Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: CustomColors.TrashRedBackground),
                child: iconslide ?? const SizedBox(),
              )),
          onTap: onTapSlide,
        ),
      ],
    );
  }
  
}
