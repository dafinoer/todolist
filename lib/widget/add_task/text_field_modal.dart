import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/add/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/widget/add_task/builder_helper.dart';

class TextFieldModal extends StatelessWidget implements BaseBuilder {
  BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;

    return BlocBuilder<AddBloc, AddState>(
        buildWhen: (prev, cur) => refreshWidget(prev, cur),
        builder: (_, state) {
          return Container(
            padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
            child: TextField(
              autofocus: true,
              style: TextStyle(fontSize: 22, fontStyle: FontStyle.normal),
              decoration: InputDecoration(
                  hintText: 'booking dinner',
                  errorText: _errorTextValue(state)),
              onChanged: _onchangeTextField,
            ),
          );
        });
  }

  void _onchangeTextField(String value) {
    _buildContext.bloc<AddBloc>().add(TextEvent(value));
  }

  String _errorTextValue(TodoState state) {
    try {
      if (state.title.isEmpty) return 'Must Fill';
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  bool refreshWidget(AddState prev, AddState curr) {
    if (prev is TodoState && curr is TodoState) {
      if (prev.title != curr.title) return true;
      return false;
    }
    return false;
  }
}
