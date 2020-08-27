import 'package:flutter/material.dart';

class TextFieldModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
      child: TextField(
        autofocus: true,
        style: TextStyle(fontSize: 22, fontStyle: FontStyle.normal),
        decoration: InputDecoration(
            border: InputBorder.none, hintText: 'booking dinner'),
      ),
    );
  }
}
