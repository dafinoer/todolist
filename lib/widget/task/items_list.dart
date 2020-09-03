import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/task/task_bloc.dart';
import 'package:todolist/bloc/task/task_event.dart';
import 'package:todolist/bloc/task/task_state.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/screen/detail/detail.dart';
import 'package:todolist/utils/date_format_helper.dart';
import 'package:todolist/widget/slide_tile_widget.dart';

class ItemList extends StatelessWidget {
  BuildContext _newContext;

  @override
  Widget build(BuildContext context) {
    _newContext = context;
    context.bloc<TaskBloc>().add(FirstOpenTask());

    return BlocBuilder<TaskBloc, TaskState>(buildWhen: (prev, curr) {
      if (prev is TaskLoaded && curr is TaskLoaded) {
        if (prev.listdata != curr.listdata)
          return true;
        else
          return false;
      }
    }, builder: (_, state) {
      if (state is TaskLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is TaskLoaded) {
        if (state.listdata.isNotEmpty) {
          return ListView.builder(
              padding: EdgeInsets.only(top: 16.0),
              itemCount: state.listdata.length,
              itemBuilder: (_, index) {
                return SlideTileWidget(
                    ontap: () => onTapEdit(
                        state.listdata[index], state.listdata[index].id),
                    title: DateFormatHelper.hourAndMinute(
                        DateTime.fromMillisecondsSinceEpoch(
                            state.listdata[index].schedule)),
                    subtitle: state.listdata[index].title,
                    iconslide: Image.asset('assets/images/trash.png'),
                    isChecked: state.listdata[index].isChecked,
                    isBellActive: false,
                    onTapCheck: () {
                      // context.bloc<HomeBloc>().add(TaskDoneEvent(
                      //     docName: state.items[index].id,
                      //     isDone: !state.items[index].isChecked));
                    },
                    onTapSlide: () {
                      // context
                      //     .bloc<HomeBloc>()
                      //     .add(DeleteTask(state.items[index].id));
                    });
              });
        } else if (state.listdata.isEmpty) {
          return Center(
            child: const Text('No More'),
          );
        }
      }
      return const SizedBox();
    });
  }

  void onTapEdit(Task task, String docId) {
    Navigator.push(
        _newContext, MaterialPageRoute(builder: (_) => Detail(task, docId)));
  }
}
