
import 'package:todolist/model/task.dart';

abstract class ScheduleEvent {

}

class ScheduleTaskEvent extends ScheduleEvent {
  final int totalTask;
  final Task task;

  ScheduleTaskEvent({this.task, this.totalTask});
}
