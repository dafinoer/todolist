

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:todolist/model/task.dart';

abstract class HomeState extends Equatable {

  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String errorText;

  const HomeError(this.errorText);
}

class HomeLists extends HomeState {
  final List<Task> items;

  final bool isMax;

  const HomeLists(this.items, this.isMax);

  HomeLists copyWith({
    List<QueryDocumentSnapshot> newitem,
    bool isMax
  }) {
    return HomeLists(newitem ?? this.items, isMax ?? this.items);
  }

  @override
  List<Object> get props => [items, isMax];
}