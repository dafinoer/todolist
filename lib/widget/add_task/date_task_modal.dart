import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todolist/bloc/add/bloc.dart';
import 'package:todolist/utils/date_format_helper.dart';
import 'package:todolist/widget/add_task/builder_helper.dart';

class DateTaskModal extends StatelessWidget implements BaseBuilder {
  final now = DateTime.now();
  TimeOfDay timeOfDay;
  BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return BlocBuilder<AddBloc, AddState>(
        buildWhen: (prev, cur) => refreshWidget(prev, cur),
        builder: (_, state) {
          DateTime time;
          if (state is TodoState) {
            time = state.dateTime;
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                txtDate(time),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: () => onTapDate(time)),
              ),
            ],
          );
        });
  }

  String txtDate(DateTime time) {
    return time != null
        ? '${DateFormatHelper.yearMonthDay(time)} ${DateFormatHelper.hourAndMinute(time)}'
        : DateFormatHelper.simpelFormat(now);
  }

  void onTapDate(DateTime time) async {
    timeOfDay = TimeOfDay.now();

    final date = await showDatePicker(
      context: _buildContext,
      initialDate: time ?? now,
      firstDate: DateTime(2019),
      lastDate: DateTime(now.year + 1),
    );

    final timeTask = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        useRootNavigator: false,
        context: _buildContext,
        initialTime: timeOfDay,
        builder: (_, child) {
          return MediaQuery(
            data: MediaQuery.of(_buildContext)
                .copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });

    if (date != null) {
      _buildContext.bloc<AddBloc>().add(DateEvent(date, dayOfTime: timeTask));
    }
  }

  @override
  bool refreshWidget(AddState prev, AddState curr) {
    if (prev is TodoState && curr is TodoState) {
      if (prev.dateTime != curr.dateTime) return true;
      return false;
    }
    return false;
  }
}
