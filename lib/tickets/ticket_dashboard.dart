import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_demo/tickets/add_ticket_dialog.dart';
import 'package:flutter_login_demo/tickets/ticket.dart';
import 'package:flutter_login_demo/tickets/firebase_database_util.dart';

class TicketDashboard extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<TicketDashboard> implements AddTicketCallback {

  bool _anchorToBottom = false;

  // instance of util class

  FirebaseDatabaseUtil databaseUtil;

  @override
  void initState() {
    super.initState();
    databaseUtil = new FirebaseDatabaseUtil();
    databaseUtil.initState();
  }

  @override
  void dispose() {
    super.dispose();
    databaseUtil.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // it will show title of screen

    Widget _buildTitle(BuildContext context) {
      return new InkWell(
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'Registro de Tickects',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }
//It will show new user icon
    List<Widget> _buildActions() {
      return <Widget>[
        new IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),               // display pop for new entry
          onPressed: () => showEditWidget(null, false),
        ),
      ];
    }

    return new Scaffold(
      appBar: new AppBar(
        title: _buildTitle(context),
        actions: _buildActions(),
      ),

      // Firebase predefile list widget. It will get user info from firebase database
      body: new FirebaseAnimatedList(
        key: new ValueKey<bool>(_anchorToBottom),
        query: databaseUtil.getUser(),
        reverse: _anchorToBottom,
        sort: _anchorToBottom
            ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
            : null,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          return new SizeTransition(
            sizeFactor: animation,
            child: showUser(snapshot),
          );
        },
      ),
    );
  }

  @override // Call util method for add user information
  void addTicket(Ticket ticket) {
    setState(() {
      databaseUtil.addTicket(ticket);
    });
  }

  @override // call util method for update old data.
  void update(Ticket ticket) {
    setState(() {
      databaseUtil.updateTicket(ticket);
    });
  }

  //It will display a item in the list of users.

  Widget showUser(DataSnapshot res) {
    Ticket ticket = Ticket.fromSnapshot(res);

    var item = new Card(
      child: new Container(
          child: new Center(
            child: new Row(
              children: <Widget>[
                new CircleAvatar(
                  radius: 30.0,
                  child: new Text(getShortName(ticket)),
                  backgroundColor: const Color(0xFF20283e),
                ),
                new Expanded(
                  child: new Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          ticket.titulo,
                          // set some style to text
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.lightBlueAccent),
                        ),
                        new Text(
                          ticket.descripcion,
                          // set some style to text
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.black54),
                        ),
                        new Text(
                          ticket.extension,
                          // set some style to text
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: const Color(0xFF167F67),
                      ),
                      onPressed: () => showEditWidget(ticket, true),
                    ),
                    new IconButton(
                      icon: const Icon(Icons.delete_forever,
                          color: const Color(0xFF167F67)),
                      onPressed: () => deleteTicket(ticket),
                    ),
                  ],
                ),
              ],
            ),
          ),
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
    );

    return item;
  }
  //Get first letter from the name of user
  String getShortName(Ticket ticket) {
    String shortName = "";
    if (!ticket.titulo.isEmpty) {
      shortName = ticket.titulo.substring(0, 1);
    }
    return shortName;
  }
  //Display popup in user info update mode.
  showEditWidget(Ticket ticket, bool isEdit) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          new AddTicketDialog().buildAboutDialog(context, this, isEdit, ticket),
    );
  }
  //Delete a entry from the Firebase console.
  deleteTicket(Ticket ticket) {
    setState(() {
      databaseUtil.deleteTicket(ticket);
    });
  }
}