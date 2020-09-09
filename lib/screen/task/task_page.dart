import 'package:flutter/material.dart';
import 'package:todolist/screen/task/task_list_page.dart';
import 'package:todolist/utils/strings.dart';
import 'package:todolist/utils/util.dart';
import 'package:todolist/widget/menu_task_widget.dart';

class TaskPage extends StatefulWidget {
  TaskPage({Key key}) : super(key: key);

  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final bottomNavigationBarIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => Container(
                      margin: EdgeInsets.only(left: 10, top: 15, bottom: 0),
                      child: Text(
                        'Projects',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.TextSubHeader),
                      ),
                    ),
                childCount: 1),
          ),
          SliverGrid.count(
            crossAxisCount: 2,
            children: [
              MenuTaskWidget(
                title: Strings.personal,
                subtitle: '24 Tasks',
                imagePath: 'assets/images/icon-user.png',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskListPage(Strings.personal))),
              ),
              MenuTaskWidget(
                  subtitle: '44 Tasks',
                  title: Strings.work,
                  imagePath: 'assets/images/icon-briefcase.png',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskListPage(Strings.work))),
                  ),
              MenuTaskWidget(
                  subtitle: '45 Tasks',
                  title: Strings.meeting,
                  imagePath: 'assets/images/icon-presentation.png',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskListPage(Strings.meeting)))
                  ),
              MenuTaskWidget(
                  subtitle: '54 Tasks',
                  title: 'Shopping',
                  imagePath: 'assets/images/icon-shopping-basket.png',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskListPage(Strings.shopping))),
                  ),
              MenuTaskWidget(
                  subtitle: '24 Tasks',
                  title: Strings.party,
                  imagePath: 'assets/images/icon-confetti.png',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskListPage(Strings.party))),
                  ),
              MenuTaskWidget(
                  subtitle: '24 Tasks',
                  title: Strings.study,
                  imagePath: 'assets/images/icon-molecule.png',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TaskListPage(Strings.study))),
                  )
            ],
          ),
        ],
      ),
    );
  }
}
