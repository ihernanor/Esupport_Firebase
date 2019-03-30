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
      Task('Atascos de papel', false),
      Task('Problemas Hardware', false),
      Task('Tóner agotado', false),
      Task('Errores de desborda-\nmiento de memoria', false),
    ]),
    TasksListModel("Redes", Colors.red, [
      Task('Problemas de conexión', false),
      Task('Proxys abiertos', false),
      Task('Gusanos y virus', false),
      Task('Línea telefónica', false),
    ]),
    TasksListModel("Fallas de Software", Colors.orange, [
      Task('Computadora lenta', false),
      Task('no enciende el CPU', false),
      Task('Paros de sistema \ninesperado', false),
      Task('La PC se reinicia o \napaga sola', false),
    ]),
    TasksListModel("Servidores", Colors.blue, [
      Task('Dejó de recibir \npeticiones', false),
      Task('Servidor muy lento', false),
      Task('Apagos de manera \nconstante', false),
      Task('No enciende', false),
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