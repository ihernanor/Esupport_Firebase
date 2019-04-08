import 'package:flutter/material.dart';
import 'package:flutter_login_demo/lista_tareas/tareas/bloc/bloque_tareas.dart';
import 'package:flutter_login_demo/lista_tareas/bloc/proveedor_bloque.dart';
import 'package:flutter_login_demo/lista_tareas/tareas/models/tareas.dart';
import 'package:flutter_login_demo/lista_tareas/tareas/tarea_fila.dart';
import 'package:flutter_login_demo/lista_tareas/utiles/aplicacion_util.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskBloc _tasksBloc = BlocProvider.of(context);
    return StreamBuilder<List<Tasks>>(
      stream: _tasksBloc.tasks,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildTaskList(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildTaskList(List<Tasks> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: list.length == 0
          ? MessageInCenterWidget("Sin tarea agregada")
          : Container(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                        key: ObjectKey(list[index]),
                        onDismissed: (DismissDirection direction) {
                          var taskID = list[index].id;
                          final TaskBloc _tasksBloc =
                              BlocProvider.of<TaskBloc>(context);
                          String message = "";
                          if (direction == DismissDirection.endToStart) {
                            _tasksBloc.updateStatus(
                                taskID, TaskStatus.COMPLETE);
                            message = "Tarea terminada";
                          } else {
                            _tasksBloc.delete(taskID);
                            message = "Tarea eliminada";
                          }
                          SnackBar snackbar =
                              SnackBar(content: Text(message));
                          Scaffold.of(context).showSnackBar(snackbar);
                        },
                        background: Container(
                          color: Colors.red,
                          child: ListTile(
                            leading:
                                Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.green,
                          child: ListTile(
                            trailing:
                                Icon(Icons.check, color: Colors.white),
                          ),
                        ),
                        child: TaskRow(list[index]));
                  }),
            ),
    );
  }
}
