import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:todolist/screen/login/login_page.dart';
import 'package:todolist/utils/firebase_auth_singleton.dart';
import 'package:todolist/utils/util.dart';
import 'package:todolist/widget/app_bars.dart';

class AppBarTaskWidget extends StatelessWidget implements PreferredSizeWidget {
  final FirebaseAuthSingleton _singleton = FirebaseAuthSingleton.singleton();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return GradientAppBar(
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomPaint(
            painter: CircleOne(),
          ),
          CustomPaint(
            painter: CircleTwo(),
          ),
        ],
      ),
      title: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello Bro!',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              'Today you have 9 tasks',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        GestureDetector(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
            child: Image.asset('assets/images/photo.png'),
          ),
          onTap: () async {
            await _singleton.auth.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
          },
        ),
      ],
      elevation: 0,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [CustomColors.HeaderBlueDark, CustomColors.HeaderBlueLight],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(10),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
          decoration: BoxDecoration(
            color: CustomColors.HeaderGreyLight,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Today Reminder',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Meeting with client',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      '13.00 PM',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/bell-left.png',
                height: mediaQuery.size.height / 15.0,
                scale: 1.3,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 80),
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(210.0);
}
