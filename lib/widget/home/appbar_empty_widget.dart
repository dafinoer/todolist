import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:todolist/screen/login/login_page.dart';
import 'package:todolist/utils/firebase_auth_singleton.dart';
import 'package:todolist/utils/strings.dart';
import 'package:todolist/utils/util.dart';
import 'package:todolist/widget/app_bars.dart';
import 'package:todolist/widget/home/appbar_title.dart';

class AppBarEmptyWidget extends StatelessWidget implements PreferredSizeWidget {
  final FirebaseAuthSingleton _singleton = FirebaseAuthSingleton.singleton();
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
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
      title: AppBarTitle(username: _singleton.auth.currentUser.displayName,),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => LoginPage()));

            storage.delete(key: Strings.token_user);
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
            child: Image.asset('assets/images/photo.png'),
          ),
        ),
      ],
      elevation: 0,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [CustomColors.HeaderBlueDark, CustomColors.HeaderBlueLight],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(75.0);
}
