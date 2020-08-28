

import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final String title;
  final DateTime schedule;
  final String emailUser;
  final String username;

  const Task({
    this.title,
    this.emailUser,
    this.schedule,
    this.username
  });

  @override
  List<Object> get props => [title, schedule, emailUser, username];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'username' : username,
      'email' : emailUser,
      'schedule' : schedule
    };
  }
}