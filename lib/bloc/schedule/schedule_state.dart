import 'package:equatable/equatable.dart';
import 'package:todolist/model/task.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleTask extends ScheduleState {
  final int totalTask;
  final Task scheduleTask;
  
  ScheduleTask({this.scheduleTask, this.totalTask});

  ScheduleTask copyWith({
    int total,
    Task newScheduleTask
  }) {
    return ScheduleTask(
      totalTask: total ?? this.totalTask,
      scheduleTask: newScheduleTask ?? this.scheduleTask
    );
  }

  @override
  List<Object> get props => [totalTask, scheduleTask];
}


class ScheduleError extends ScheduleState {
  final String text;
  const ScheduleError(this.text);
}