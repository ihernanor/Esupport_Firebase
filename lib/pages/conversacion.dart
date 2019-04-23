import 'package:flutter/material.dart';

class Conversaciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Conversaciones',
        home: Scaffold(
            appBar: AppBar(
                title: Text('Conversaciones')
            ),
            body: Center(
                child: Text('¡Próximanente!')
            )
        )
    );
  }
}