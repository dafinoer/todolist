import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/login/bloc.dart';
import 'package:todolist/bloc/login/login_bloc.dart';
import 'package:todolist/screen/main_page.dart';
import 'package:todolist/utils/util.dart';

class ButtonLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(buildWhen: (prev, curr) {
      if (prev is LoginOnLoading && curr is LoginOnLoading) {
        return prev.isLoading != curr.isLoading;
      }
    }, builder: (_, state) {
      return Expanded(
        flex: 1,
        child: RaisedButton(
          onPressed: () {
            context.bloc<LoginBloc>().add(LoginOnSubmit());
          },
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.4,
            height: 60,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  CustomColors.GreenLight,
                  CustomColors.GreenDark,
                ],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: CustomColors.GreenShadow,
                  blurRadius: 15.0,
                  spreadRadius: 7.0,
                  offset: Offset(0.0, 0.0),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Center(
              child: state is LoginOnLoading && state.isLoading
                  ? CircularProgressIndicator()
                  : const Text(
                      'Google SignIn',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
            ),
          ),
        ),
      );
    });
  }
}
