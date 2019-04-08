import 'package:flutter/material.dart';
import 'package:flutter_login_demo/lista_tareas/bloc/proveedor_bloque.dart';
import 'package:flutter_login_demo/lista_tareas/tareas/bloc/bloque_tareas.dart';
import 'package:flutter_login_demo/lista_tareas/tareas/models/tareas.dart';
import 'package:flutter_login_demo/lista_tareas/tareas/tarea_db.dart';
import 'package:flutter_login_demo/lista_tareas/tareas/tareas_completadas/tarea_fila_completada.dart';

class TaskCompletedPage extends StatelessWidget {
  final TaskBloc _taskBloc = TaskBloc(TaskDB.get());

  @override
  Widget build(BuildContext context) {
    _taskBloc.filterByStatus(TaskStatus.COMPLETE);
    return BlocProvider(
      bloc: _taskBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tarea terminada"),
        ),
        body: StreamBuilder(
            stream: _taskBloc.tasks,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          key: ObjectKey(snapshot.data[index]),
                          direction: DismissDirection.endToStart,
                          background: Container(),
                          onDismissed: (DismissDirection directions) {
                            if (directions == DismissDirection.endToStart) {
                              var taskID = snapshot.data[index].id;
                              _taskBloc.updateStatus(
                                  taskID, TaskStatus.PENDING);
                              SnackBar snackbar =
                                  SnackBar(content: Text("Tarea Deshacer"));
                              Scaffold.of(context).showSnackBar(snackbar);
                            }
                          },
                          secondaryBackground: Container(
                            color: Colors.grey,
                            child: ListTile(
                              trailing: Text("DESHACER",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          child: TaskCompletedRow(snapshot.data[index]));
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
