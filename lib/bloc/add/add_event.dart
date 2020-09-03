

import 'package:flutter/material.dart';

abstract class AddEvent {}


class TextEvent extends AddEvent {
  final String text;
  
  TextEvent(this.text); 
}

class TypeChoice extends AddEvent {
  final String txtType;

  TypeChoice(this.txtType);
}

class DateEvent extends AddEvent {
  final DateTime dateTime;
  final TimeOfDay dayOfTime;

  DateEvent(this.dateTime, {this.dayOfTime});
}

class SubmitEvent extends AddEvent {}

class SubmitEdit extends AddEvent{
  final String idDoc;

  SubmitEdit(this.idDoc);
}