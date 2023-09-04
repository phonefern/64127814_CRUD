import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Users.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
Widget build(BuildContext context) {
  Users user = ModalRoute.of(context)!.settings.arguments as Users;
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
              title: const Text("Name"),
              subtitle: Text(
                ("${user.fullname}"),
                style: const TextStyle(
                  color: Colors.black, // สีข้อความ
                  fontSize: 16, // ขนาดตัวอักษร
                ),
              ),
            ),
            ListTile(
              title: const Text("Email"),
              subtitle: Text(
                ("${user.email}"),
                style: const TextStyle(
                  color: Colors.black, // สีข้อความ
                  fontSize: 16, // ขนาดตัวอักษร
                ),
              ),
            ),
            ListTile(
              title: const Text("Gender"),
              subtitle: Text(
                ("${user.gender}"),
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

