import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Patients.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
Widget build(BuildContext context) {
  Patients patient = ModalRoute.of(context)!.settings.arguments as Patients;
  return Scaffold(
    appBar: AppBar(
      title: const Text("User Info"),
    ),
    body: Container(
      margin: const EdgeInsets.all(10),
      child: Card(
        child: ListView(
          children: [
            ListTile(
              title: const Text("ชื่อ - สกุล"),
              subtitle: Text(
                ("${patient.fullname}"),
                style: const TextStyle(
                  color: Colors.black, // สีข้อความ
                  fontSize: 16, // ขนาดตัวอักษร
                ),
              ),
            ),
            ListTile(
              title: const Text("HN"),
              subtitle: Text(
                ("${patient.hn}"),
                style: const TextStyle(
                  color: Colors.black, // สีข้อความ
                  fontSize: 16, // ขนาดตัวอักษร
                ),
              ),
            ),
            ListTile(
              title: const Text("เพศ"),
              subtitle: Text(
                ("${patient.gender}"),
                style: const TextStyle(
                  color: Colors.black, // สีข้อความ
                  fontSize: 16, // ขนาดตัวอักษร
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  }

