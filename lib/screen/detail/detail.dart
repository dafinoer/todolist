import 'package:flutter/material.dart';
import 'package:todolist/widget/app_bars.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppbar(),
      body: Center(child: Text('this is task'),),
    );
  }
}