import 'package:firebase_database/firebase_database.dart';

class Ticket {

  String _id;
  String _titulo;
  String _descripcion;
  String _fecha;
  String _extension;

  Ticket(this._id,this._titulo, this._descripcion, this._fecha, this._extension);

  String get titulo => _titulo;

  String get descripcion => _descripcion;

  String get fecha => _fecha;

  String get extension => _extension;

  String get id => _id;

  Ticket.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _titulo = snapshot.value['titulo'];
    _descripcion = snapshot.value['descripcion'];
    _fecha = snapshot.value['fehca'];
    _extension = snapshot.value['extension'];
  }
}