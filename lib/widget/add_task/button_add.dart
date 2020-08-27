import 'package:flutter/material.dart';
import 'package:todolist/utils/util.dart';

class ButtonAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {},
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: 60,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              CustomColors.BlueLight,
              CustomColors.BlueDark,
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          boxShadow: [
            BoxShadow(
              color: CustomColors.BlueShadow,
              blurRadius: 2.0,
              spreadRadius: 1.0,
              offset: Offset(0.0, 0.0),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Center(
          child: const Text(
            'Add task',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
