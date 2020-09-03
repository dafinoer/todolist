import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:todolist/model/task.dart';

abstract class TaskEvent extends Equatable{
  const TaskEvent();
  
  @override
  List<Object> get props => [];

}

class FirstOpenTask extends TaskEvent {}

class ListTask extends TaskEvent{
  final List<Task> tasks;
  ListTask(this.tasks);
}

class TypeTask extends TaskEvent{
  final String typeOftitle;

  TypeTask(this.typeOftitle);
}


class TypeTaskError extends TaskEvent {
  final String error;

  TypeTaskError(this.error);
}