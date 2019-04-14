import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_login_demo/tickets/ticket.dart';

class FirebaseDatabaseUtil {
  DatabaseReference _counterRef;
  DatabaseReference _userRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  FirebaseDatabase database = new FirebaseDatabase();
  int _counter;
  DatabaseError error;

  static final FirebaseDatabaseUtil _instance =
  new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    // Demonstrates configuring to the database using a file
    _counterRef = FirebaseDatabase.instance.reference().child('counter');
    // Demonstrates configuring the database directly

    _userRef = database.reference().child('ticket');
    database.reference().child('counter').once().then((DataSnapshot snapshot) {
      print('Conectado a la segunda base de datos y leer ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);

    _counterSubscription = _counterRef.onValue.listen((Event event) {
      error = null;
      _counter = event.snapshot.value ?? 0;
    }, onError: (Object o) {
      error = o;
    });
  }

  DatabaseError getError() {
    return error;
  }

  int getCounter() {
    return _counter;
  }

  DatabaseReference getUser() {
    return _userRef;
  }

  addTicket(Ticket ticket) async {
    final TransactionResult transactionResult =
    await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

    if (transactionResult.committed) {
      _userRef.push().set(<String, String>{
        "titulo": "" + ticket.titulo,
        "fecha": "" + ticket.fecha,
        "descripcion": "" + ticket.descripcion,
        "extension": "" + ticket.extension,
      }).then((_) {
        print('Transacción comprometida.');
      });
    } else {
      print('Transacción no comprometida.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  void deleteTicket(Ticket ticket) async {
    await _userRef.child(ticket.id).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updateTicket(Ticket ticket) async {
    await _userRef.child(ticket.id).update({
      "titulo": "" + ticket.titulo,
      "fecha": "" + ticket.fecha,
      "descripcion": "" + ticket.descripcion,
      "extensión": "" + ticket.extension,
    }).then((_) {
      print('Transacción comprometida.');
    });
  }

  void dispose() {
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }
}
