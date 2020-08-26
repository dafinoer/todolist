import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist/bloc/navigator/bloc.dart';
import 'package:todolist/screen/onboard/onboarding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/utils/util.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //top bar color
      ),
    );
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => NavigatorBloc(NavigatorIndexState(0)))
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              canvasColor: CustomColors.GreyBackground,
              fontFamily: 'rubik',
            ),
            home: Onboarding()));
  }
}
