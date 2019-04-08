import 'package:flutter/material.dart';
import 'package:flutter_login_demo/lista_tareas/bloc/proveedor_bloque.dart';
import 'package:flutter_login_demo/lista_tareas/tareas/bloc/bloque_tareas.dart';
import 'package:flutter_login_demo/lista_tareas/etiquetas/etiquetas_db.dart';
import 'package:flutter_login_demo/lista_tareas/proyectos/proyecto_db.dart';
import 'package:flutter_login_demo/lista_tareas/proyectos/proyecto.dart';
import 'package:flutter_login_demo/lista_tareas/acerca_de_nosotros/acerca_de.dart';
import 'package:flutter_login_demo/lista_tareas/home_tareas/home_bloc.dart';
import 'package:flutter_login_demo/lista_tareas/etiquetas/bloque_etiquetas.dart';
import 'package:flutter_login_demo/lista_tareas/etiquetas/widget_etiqueta.dart';
import 'package:flutter_login_demo/lista_tareas/proyectos/bloque_proyecto.dart';
import 'package:flutter_login_demo/lista_tareas/proyectos/widget_proyecto.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("¡Bienvenido!"),
            accountEmail: Text("Rubén Verduzo López"),
            otherAccountsPictures: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 36.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<bool>(
                          builder: (context) => AboutUsScreen()),
                    );
                  })
            ],
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              backgroundImage: AssetImage("assets/images/psi.png"),
            ),
          ),
          ListTile(
              leading: Icon(Icons.inbox),
              title: Text("Bandeja de entrada"),
              onTap: () {
                var project = Project.getInbox();
                homeBloc.applyFilter(
                    project.name, Filter.byProject(project.id));
                Navigator.pop(context);
              }),
          ListTile(
              onTap: () {
                homeBloc.applyFilter("Hoy", Filter.byToday());
                Navigator.pop(context);
              },
              leading: Icon(Icons.calendar_today),
              title: Text("Hoy")),
          ListTile(
            onTap: () {
              homeBloc.applyFilter("Próximos 7 dias", Filter.byNextWeek());
              Navigator.pop(context);
            },
            leading: Icon(Icons.calendar_today),
            title: Text("Próximos 7 dias"),
          ),
          BlocProvider(
            bloc: ProjectBloc(ProjectDB.get()),
            child: ProjectPage(),
          ),
          BlocProvider(
            bloc: LabelBloc(LabelDB.get()),
            child: LabelPage(),
          )
        ],
      ),
    );
  }
}
