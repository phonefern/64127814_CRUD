import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/home.dart';


 void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Project',
      theme: ThemeData(
        primaryColor: Colors.amber,
      ),
      home:HomeScreen()
      
    );
  }
}