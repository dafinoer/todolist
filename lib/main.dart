import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todolist/bloc/navigator/bloc.dart';
import 'package:todolist/screen/main_page.dart';
import 'package:todolist/screen/onboard/onboarding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/utils/firebase_auth_singleton.dart';
import 'package:todolist/utils/shared_pref.dart';
import 'package:todolist/utils/util.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  SharePref sharedpref;

  Future<User> _usernow;

  FirebaseAuthSingleton user_auth;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //top bar color
      ),
    );
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    initializeFlutterFire();

    sharedpref = SharePref.singleton();
    sharedpref.build();

    super.initState();
  }

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      user_auth = FirebaseAuthSingleton.singleton();
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => NavigatorBloc(NavigatorIndexState(0))),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              canvasColor: CustomColors.GreyBackground,
              fontFamily: 'rubik',
            ),
            home: _onCheckSession()));
  }

  Widget _onCheckSession() {
    if (user_auth != null) {
      if (user_auth.auth.currentUser != null) {
        return MainPage();
      } else {
        return Onboarding();
      }
    } else {
      return Scaffold(
        body: const SizedBox(),
      );
    }
  }
}
