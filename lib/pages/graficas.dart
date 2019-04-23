import 'package:flutter/material.dart';

class Graficas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gráficas',
        home: Scaffold(
            appBar: AppBar(
                title: Text('Gráficas')
            ),
            body: Center(
                child: Text('¡Próximanente!')
            )
        )
    );
  }
}