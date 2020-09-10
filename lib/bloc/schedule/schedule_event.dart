
import 'package:todolist/model/task.dart';

abstract class ScheduleEvent {

}

class FirstOpenSchedule extends ScheduleEvent {

}


class ScheduleTask extends ScheduleEvent {
  final Task task;

  ScheduleTask(this.task);
}