import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/login.dart';
// ignore: unused_import
import 'package:flutter_application_1/Screen/register.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ลงทะเบียนผู้ใช้/เข้าสู่ระบบ"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/logo.png'),
              
              Container(
                margin: EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text("สร้างบัญชีผู้ใช้", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Registerscreen();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              ),
               Container(
                margin: EdgeInsets.all(10.0),
                child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text("เข้าสู่ระบบ", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
               ),
            ]
            
          ),
        ),
      ),
    );
  }
}
