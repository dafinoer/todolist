import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/screen/detail/edit_detail.dart';
import 'package:todolist/utils/date_format_helper.dart';
import 'package:todolist/utils/util.dart';
import 'package:todolist/widget/app_bars.dart';

class Detail extends StatelessWidget {
  final Task task;

  final String docId;

  Detail(this.task, this.docId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: GradientAppBar(
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomPaint(
                painter: CircleOne(),
              ),
              CustomPaint(
                painter: CircleTwo(),
              ),
            ],
          ),
          title: Container(child: const Text('Detail')),
          elevation: 0,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [CustomColors.HeaderBlueDark, CustomColors.HeaderBlueLight],
          ),
          actions: [
            
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Title',
              ),
              subtitle: Text(task.title),
            ),
            ListTile(
              title: Text('Type Task'),
              subtitle: Text(task.typeTask),
            ),
            ListTile(
              title: Text('Date'),
              subtitle: Text(DateFormatHelper.yearMonthDay(
                  DateTime.fromMillisecondsSinceEpoch(task.schedule))),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Icon(Icons.edit),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                CustomColors.PurpleLight,
                CustomColors.PurpleDark,
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
            boxShadow: [
              BoxShadow(
                color: CustomColors.PurpleShadow,
                blurRadius: 10.0,
                spreadRadius: 5.0,
                offset: Offset(0.0, 0.0),
              ),
            ],
          ),
        ),
        onPressed: () => _onTapEdit(context),
      ),
    );
  }

  void _onTapEdit(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => EditDetailPage(task, docId)));
  }
}
