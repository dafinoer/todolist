import 'package:equatable/equatable.dart';
import 'package:todolist/bloc/schedule/bloc.dart';
import 'package:todolist/model/task.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleWait extends ScheduleState{}

class ScheduleList extends ScheduleState {

  final Task scheduleTask;

  ScheduleList(this.scheduleTask);
}


class ScheduleError extends ScheduleState {
  final String text;
  const ScheduleError(this.text);
}