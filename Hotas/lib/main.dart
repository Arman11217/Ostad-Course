
import 'package:flutter/material.dart';
import 'package:hotas/screens/home_screen.dart';

void main(){
  runApp(CrudApp());
}

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Crud app",
      theme: ThemeData(
          colorSchemeSeed: Colors.blue
      ),
      home: HomeScreen(),
    );
  }
}
