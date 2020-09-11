import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/date_symbol_data_local.dart';
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
import 'package:todolist/utils/fcm_utils.dart';
import 'package:todolist/utils/firebase_auth_singleton.dart';
import 'package:todolist/utils/shared_pref.dart';
import 'package:todolist/utils/strings.dart';
import 'package:todolist/utils/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MainBlocObserver();
  await Firebase.initializeApp();
  final SharePref sharedpref = SharePref.singleton();
  initializeDateFormatting().then((value) => runApp(App()));
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final SharePref sharedpref = SharePref.singleton();

  final notifBloc = ScheduleBloc(ScheduleTask());

  final FcmUtils fcmUtils = FcmUtils();

  final storage = FlutterSecureStorage();

  bool isFirstInstall = true;

  bool isLogin = false;

  @override
  void initState() {
    sharedpref.build();
    fcmUtils.getTokenFirebase().then((value) => initializeFlutterFire());
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent, //top bar color
    //   ),
    // );
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    super.initState();
  }

  void initializeFlutterFire() async {
    try {
      isFirstInstall = sharedpref.getFirstInstallStatus() == null;
      var itemToken = await storage.read(key: Strings.token_user);
      if (itemToken != null) isLogin = true;

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
            ],
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  canvasColor: CustomColors.GreyBackground,
                  fontFamily: 'rubik',
                ),
                home: _sessionWidget())));
  }

  Widget _sessionWidget() {
    if (isLogin) {
      return MainPage();
    } else if (isFirstInstall == null) {
      return Scaffold(body: const SizedBox(),);
    } else if (isFirstInstall) {
      return Onboarding();
    } else if (!isFirstInstall) {
      return LoginPage();
    }
  }
}
