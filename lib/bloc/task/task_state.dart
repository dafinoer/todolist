

import 'package:equatable/equatable.dart';
import 'package:todolist/model/task.dart';

abstract class TaskState extends Equatable{
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> listdata;

  const TaskLoaded(this.listdata);
  
  @override
  List<Object> get props => [listdata];
}

class TaskError extends TaskState {
  final String error;

  const TaskError({this.error});
}