import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/home/bloc.dart';
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
            return ListView.builder(
                padding: EdgeInsets.only(top: 16.0),
                itemCount: state.items.length,
                itemBuilder: (_, index) {
                  return SlideTileWidget(
                      title: '08.00 AM',
                      subtitle: state.items[index].title,
                      iconslide: Image.asset('assets/images/trash.png'),
                      isChecked: state.items[index].isChecked,
                      isBellActive: false,
                      onTapCheck: () {
                        context.bloc<HomeBloc>().add(TaskDoneEvent(docName: state.items[index].id, isDone: !state.items[index].isChecked));
                      },
                      onTapSlide: () {
                        print(state.items[index].id);
                        // context.bloc<HomeBloc>().add(TaskDoneEvent(docName: state.items[index].id));
                      });
                });
          }
        }));
  }
}
