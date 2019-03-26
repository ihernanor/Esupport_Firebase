import 'package:flutter/material.dart';
import 'package:flutter_login_demo/models/lista_tickets.dart';
import 'package:flutter_login_demo/models/tarjeta_tickets.dart';

//New Task Page
class TicketPage extends StatefulWidget {
  TicketPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage>{

  /// Navigate to new task list
  //void _addTaskPressed() => Navigator.of(context).pushNamed('/new');
  PageController _pageController = PageController(viewportFraction: 0.5432);

  /// tasks list
  static final List<TasksListModel> tasksList = [
    TasksListModel("Impresora", Colors.indigo, [
      Task('Book Flight', true),
      Task('Passport check', true),
      Task('Packing luggage', false),
      Task('Hotel reservation', false),
    ]),
    TasksListModel("Redes", Colors.red, [
      Task('Buy milk', false),
      Task('Plan weekend outing', false),
      Task('Publish friday', true),
      Task('Run 3 miles', false),
    ]),
    TasksListModel("Fallas de Software", Colors.orange, [
      Task('Buy milk', false),
      Task('Plan weekend outing', true),
      Task('Wash clothes', true),
      Task('Update database', false),
    ]),
    TasksListModel("Servidores", Colors.blue, [
      Task('Study', true),
      Task('Read comics', false),
      Task('Spend', true),
      Task('Hit the books at 4pm', false),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Column(
          children: <Widget>[
            Center(
              heightFactor: 5.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container( color: Colors.grey, height: 0.5,),
                  ),
                  Expanded(
                      flex: 8,
                      child: Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: new Row(
                            children: <Widget>[
                              Text('Ticket',
                                style: new TextStyle(fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(' de Consulta',
                                style: new TextStyle(fontSize: 20.0,
                                    color: Colors.grey),
                              )
                            ],
                          )
                      )
                  ),
                  Expanded(
                    flex: 5,
                    child: Container( color: Colors.grey, height: 0.5,),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: _openTask,
              child: Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 8.0),
                  height: 300.0,
                  child: PageView(
                    controller: _pageController,
                    children: tasksList.map((task){
                      return TaskListCard(task);
                    }).toList(),
                  )
              ),
            ),
          ],
        )
    );
  }

  void _openTask(){

  }
}