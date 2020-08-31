

import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final String id;
  final String title;
  final int schedule;
  final String emailUser;
  final String username;
  final String typeTask;
  final bool isChecked;

  const Task({
    this.title,
    this.id,
    this.emailUser,
    this.schedule,
    this.username,
    this.typeTask,
    this.isChecked
  });

  @override
  List<Object> get props => [title, schedule, emailUser, username, typeTask, id, isChecked];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'username' : username,
      'email' : emailUser,
      'schedule' : schedule,
      'type_task' : typeTask,
      'doc_id' : id,
      'is_checked' : isChecked
    };
  }


  factory Task.fromJson(Map map, String idDoc){
    return Task(
      id: idDoc ?? '',
      schedule: map['schedule'] ?? 0,
      title: map['title'] ?? '',
      emailUser: map['email'] ?? '',
      typeTask: map['type_task'] ?? '',
      username: map['username'] ?? '',
      isChecked: map['is_checked'] ?? false
    );
  }

  static Map<String, dynamic> checkUpdate(bool status) {
    return {'is_checked' : status};
  }
}