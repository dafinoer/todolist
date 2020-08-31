


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/bloc/home/bloc.dart';
import 'package:todolist/bloc/home/home_state.dart';
import 'package:todolist/model/task.dart';

abstract class HomeEvent {

}

class ListEvent extends HomeEvent {
  final List<Task> itemTask;

  ListEvent({this.itemTask});
}

class FirstOpen extends HomeEvent {}

class PaginationEventTask extends HomeEvent{
  final DocumentSnapshot snapshot;
  final int limit;

  PaginationEventTask({this.snapshot, this.limit});
}