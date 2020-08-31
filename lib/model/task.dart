

import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final String title;
  final int schedule;
  final String emailUser;
  final String username;
  final String typeTask;

  const Task({
    this.title,
    this.emailUser,
    this.schedule,
    this.username,
    this.typeTask
  });

  @override
  List<Object> get props => [title, schedule, emailUser, username, typeTask];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'username' : username,
      'email' : emailUser,
      'schedule' : schedule,
      'type_task' : typeTask
    };
  }


  factory Task.fromJson(Map map){
    return Task(
      schedule: map['schedule'] ?? 0,
      title: map['title'] ?? '',
      emailUser: map['email'] ?? '',
      typeTask: map['type_task'] ?? '',
      username: map['username'] ?? ''
    );
  }
}