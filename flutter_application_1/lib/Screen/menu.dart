import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/login.dart';
import 'package:flutter_application_1/Screen/welcome.dart';


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'users CRUD',
      initialRoute: '/',
      routes: {
        '/' :(context) => welcome(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}