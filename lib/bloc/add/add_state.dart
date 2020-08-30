import 'package:equatable/equatable.dart';
import 'package:todolist/bloc/add/bloc.dart';

abstract class AddState extends Equatable {
  const AddState();
  @override
  List<Object> get props => [];
}

class AddError extends AddState {
  final String error;
  const AddError(this.error);

  @override
  List<Object> get props => [error];
}

class SubmitLoading extends AddState {
  final bool isLoading;

  const SubmitLoading(this.isLoading);

  SubmitLoading copyWith({bool isLoading}) {
    return SubmitLoading(isLoading ?? this.isLoading);
  }
  
  @override
  List<Object> get props => [isLoading];
}

class TodoState extends AddState {
  final String title;
  final String type;
  final DateTime dateTime;
  final bool isLoading;

  const TodoState({this.title, this.type, this.dateTime, this.isLoading = false});

  TodoState copyWith({String title, String type, DateTime dateTime, bool isLoading}) {
    return TodoState(
        type: type ?? this.type,
        title: title ?? this.title,
        dateTime: dateTime ?? this.dateTime,
        isLoading: isLoading ?? this.isLoading
        );
  }

  @override
  List<Object> get props => [title, type, dateTime, isLoading];
}
