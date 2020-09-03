import 'package:flutter/material.dart';
import 'package:todolist/utils/util.dart';

class MenuTaskWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final Function onTap;

  MenuTaskWidget(
      {@required this.subtitle,
      @required this.title,
      @required this.imagePath,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FlatButton(onPressed: onTap, child: item()),
        decoration: BoxDecoration(
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
          color: Colors.white,
        ),
        margin: EdgeInsets.all(10),
        height: 150.0);
  }

  Widget item() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 65,
            height: 65,
            child: Image.asset(imagePath),
            decoration: const BoxDecoration(
              color: CustomColors.GreenBackground,
              borderRadius: BorderRadius.all(
                Radius.circular(50.0),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
                fontSize: 17,
                color: CustomColors.TextHeaderGrey,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            subtitle ?? '',
            style:
                TextStyle(fontSize: 9, color: CustomColors.TextSubHeaderGrey),
          ),
        ],
      ),
    );
  }
}
