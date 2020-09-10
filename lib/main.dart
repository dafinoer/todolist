import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todolist/bloc/home/bloc.dart';
import 'package:todolist/bloc/home/home_bloc.dart';
import 'package:todolist/bloc/navigator/bloc.dart';
import 'package:todolist/bloc/notif/bloc.dart';
import 'package:todolist/bloc/observer/main_observer.dart';
import 'package:todolist/bloc/schedule/bloc.dart';
import 'package:todolist/screen/login/login_page.dart';
import 'package:todolist/screen/main_page.dart';
import 'package:todolist/screen/onboard/onboarding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/utils/firebase_auth_singleton.dart';
import 'package:todolist/utils/shared_pref.dart';
import 'package:todolist/utils/util.dart';

void main() {
  Bloc.observer = MainBlocObserver();
  runApp(App());
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final SharePref sharedpref = SharePref.singleton();

  final notifBloc = ScheduleBloc(ScheduleWait());

  FirebaseAuthSingleton user_auth;

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  bool isFirstPage = true;

  @override
  void initState() {
    sharedpref.build();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //top bar color
      ),
    );
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
    firebaseMessaging.getToken().then((value) {
      print(value);
      if(sharedpref.getValueSharePref('token') != null){
        isFirstPage = false;
      } else {
        sharedpref.setToken(value);
      }
      initializeFlutterFire();
    });
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
  void dispose() {
    notifBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: notifBloc,
        child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => NavigatorBloc(NavigatorIndexState(0))),
              BlocProvider(create: (_) => HomeBloc(HomeLoading(), notifBloc)),
              BlocProvider(create: (_) => NotifBloc(NotifFirst(), firebaseMessaging),)
            ],
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  canvasColor: CustomColors.GreyBackground,
                  fontFamily: 'rubik',
                ),
                home: _onCheckSession())));
  }

  Widget _onCheckSession() {
    if (user_auth != null) {
      if (user_auth.auth.currentUser != null) {
        return MainPage();
      } else if(!isFirstPage){
        return LoginPage();
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
