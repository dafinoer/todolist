import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/login/bloc.dart';
import 'package:todolist/bloc/login/login_bloc.dart';
import 'package:todolist/screen/main_page.dart';
import 'package:todolist/utils/util.dart';
import 'package:todolist/widget/login/item_login_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => LoginBloc(LoginOnLoading(false)),
         child: ItemLoginWidget())
    );
  }
}
