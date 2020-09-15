import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/home/bloc.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/screen/detail/detail.dart';
import 'package:todolist/utils/date_format_helper.dart';
import 'package:todolist/widget/slide_tile_widget.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final bottomNavigationBarIndex = 0;

  @override
  void initState() {
    if (context.bloc<HomeBloc>().state is HomeLoading) {
      context.bloc<HomeBloc>().add(FirstOpen());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<HomeBloc, HomeState>(builder: (_, state) {
          if (state is HomeLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is HomeError) {
            return Center(
              child: const Text('something wrong'),
            );
          }

          if (state is HomeLists) {
            if(state.items.isNotEmpty){
              return ListView.builder(
                padding: EdgeInsets.only(top: 16.0),
                itemCount: state.items.length,
                itemBuilder: (_, index) {
                  return SlideTileWidget(
                      ontap: () =>
                          onTapEdit(state.items[index], state.items[index].id),
                      title: DateFormatHelper.hourAndMinute(
                          DateTime.fromMillisecondsSinceEpoch(
                              state.items[index].schedule )),
                      subtitle: state.items[index].title,
                      iconslide: Image.asset('assets/images/trash.png'),
                      isChecked: state.items[index].isChecked,
                      isBellActive: false,
                      onTapCheck: () {
                        context.bloc<HomeBloc>().add(TaskDoneEvent(
                            docName: state.items[index].id,
                            isDone: !state.items[index].isChecked));
                      },
                      onTapSlide: () {
                        context
                            .bloc<HomeBloc>()
                            .add(DeleteTask(state.items[index].id));
                      });
                });
            } else {
              return Center(child: Text('No Have Item'),);
            }
          }
        }));
  }

  void onTapEdit(Task task, String docId) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => Detail(task, docId)));
  }
}
