import 'package:flutter/material.dart';
import 'package:flutter_login_demo/tickets/ticket.dart';

class AddTicketDialog {
  final teTitulo = TextEditingController();
  final teDescripcion = TextEditingController();
  final teFecha = TextEditingController();
  final teExtension = TextEditingController();
  Ticket ticket;

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  Widget buildAboutDialog(BuildContext context,
      AddTicketCallback _myHomePageState, bool isEdit, Ticket ticket) {
    if (ticket != null) {
      this.ticket = ticket;
      teTitulo.text = ticket.titulo;
      teDescripcion.text = ticket.descripcion;
      teFecha.text = ticket.fecha;
      teExtension.text = ticket.extension;
    }

    return new AlertDialog(
      title: new Text(isEdit ? '¡Editar ticket!' : '¡Anadir nuevo ticket!'),
      content: new SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Título", teTitulo),
            getTextField("Descripción", teDescripcion),
            getTextField("DD-MM-AAAA", teFecha),
            getTextField("Extensión", teExtension),
            new GestureDetector(
              onTap: () => onTap(isEdit, _myHomePageState, context),
              child: new Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(isEdit ? "Editar" : "Añadir",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(
        controller: inputBoxController,
        decoration: new InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }

  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: new Text(
        buttonLabel,
        style: new TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }

  Ticket getData(bool isEdit) {
    return new Ticket(isEdit ? ticket.id : "", teTitulo.text, teDescripcion.text,
        teFecha.text, teExtension.text);
  }

  onTap(bool isEdit, AddTicketCallback _myHomePageState, BuildContext context) {
    if (isEdit) {
      _myHomePageState.update(getData(isEdit));
    } else {
      _myHomePageState.addTicket(getData(isEdit));
    }

    Navigator.of(context).pop();

  }
}
//Call back of user dashboad
abstract class AddTicketCallback {
  void addTicket(Ticket ticket);

  void update(Ticket ticket);
}