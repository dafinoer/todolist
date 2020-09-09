import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/login/bloc.dart';
import 'package:todolist/bloc/login/login_bloc.dart';
import 'package:todolist/screen/main_page.dart';
import 'package:todolist/utils/util.dart';
import 'package:todolist/widget/login/button_login_widget.dart';

class ItemLoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (_, state) {
        if (state is LoginSuccesState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        } else if (state is LoginOnError) {
          final snackBar = SnackBar(content: Text(state.errorTxt));
          Scaffold.of(context).showSnackBar(snackBar);
        }
      },
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Hero(
              tag: 'Clipboard',
              child: Image.asset('assets/images/Clipboard.png'),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: CustomColors.TextHeader),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris pellentesque erat in blandit luctus.',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: CustomColors.TextBody,
                        fontFamily: 'opensans'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          ButtonLogin(),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
