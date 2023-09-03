import 'package:flutter/material.dart';

import 'package:flutter_application_1/Screen/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const start(),
    );
  }
}

class start extends StatefulWidget {
  const start({super.key});

  @override
  State<start> createState() => _startState();
}

class _startState extends State<start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color:Colors.white,
       child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 150, 20, 30),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 70),
            Image.asset('assets/images/logo.png'),
            const SizedBox(height: 70),
            const Text(
              'Patient information system',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Patient information system for A Better Future',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 100),
            SubmitButton(),
          ]),
        ),
      ),
      )
    );
  }

  Widget SubmitButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }));
      },
      style: customButtonStyle(),
      child: const Text("GET STARTED"),
    );
  }

  ButtonStyle customButtonStyle() {
    return ElevatedButton.styleFrom(
      primary: const Color.fromARGB(
          255, 96, 122, 167), // Set the button's background color
      onPrimary: Colors.white, // Set the button's text color
      textStyle: const TextStyle(fontSize: 18), // Set the text style
      padding: const EdgeInsets.symmetric(
          horizontal: 50, vertical: 18), // Set padding
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35), // Set button border radius
      ),
    );
  }
}
