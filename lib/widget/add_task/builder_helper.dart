import 'package:todolist/bloc/add/bloc.dart';

abstract class BaseBuilder {
  bool refreshWidget(AddState prev, AddState curr);
}
