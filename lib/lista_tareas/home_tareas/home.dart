import 'package:flutter/material.dart';
import 'package:flutter_login_demo/lista_tareas/bloc/proveedor_bloque.dart';
import 'package:flutter_login_demo/lista_tareas/etiquetas/etiquetas_db.dart';
import 'package:flutter_login_demo/lista_tareas/proyectos/proyecto_db.dart';
import 'package:flutter_login_demo/lista_tareas/tareas/bloc/agregar_bloque_tareas.dart';
import 'package:flutter_login_demo/lista_tareas/tareas/bloc/bloque_tareas.dart';
import 'package:flutter_login_demo/lista_tareas/tareas/tarea_db.dart';
import 'package:flutter_login_demo/lista_tareas/home_tareas/home_bloc.dart';
import 'package:flutter_login_demo/lista_tareas/home_tareas/drawer.dart';
import 'package:flutter_login_demo/lista_tareas/tareas/añadir_tarea.dart';
import 'package:flutter_login_demo/lista_tareas/tareas/tareas_completadas/tareas_completadas.dart';
import 'package:flutter_login_demo/lista_tareas/tareas/widget_tarea.dart';

class TareaHomePage extends StatelessWidget {
  final TaskBloc _taskBloc = TaskBloc(TaskDB.get());

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of(context);
    homeBloc.filter.listen((filter) {
      _taskBloc.updateFilters(filter);
    });
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<String>(
            initialData: 'Hoy',
            stream: homeBloc.title,
            builder: (context, snapshot) {
              return Text(snapshot.data);
            }),
        actions: <Widget>[buildPopupMenu(context)],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        onPressed: () async {
          var blocProviderAddTask = BlocProvider(
            bloc: AddTaskBloc(TaskDB.get(), ProjectDB.get(), LabelDB.get()),
            child: AddTaskScreen(),
          );
          await Navigator.push(
            context,
            MaterialPageRoute<bool>(builder: (context) => blocProviderAddTask),
          );
          _taskBloc.refresh();
        },
      ),
      drawer: SideDrawer(),
      body: BlocProvider(
        bloc: _taskBloc,
        child: TasksPage(),
      ),
    );
  }

// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).
  Widget buildPopupMenu(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      onSelected: (MenuItem result) async {
        switch (result) {
          case MenuItem.taskCompleted:
            await Navigator.push(
              context,
              MaterialPageRoute<bool>(
                  builder: (context) => TaskCompletedPage()),
            );
            _taskBloc.refresh();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
            const PopupMenuItem<MenuItem>(
              value: MenuItem.taskCompleted,
              child: const Text('Tareas completadas'),
            )
          ],
    );
  }
}

// This is the type used by the popup menu below.
enum MenuItem { taskCompleted }
