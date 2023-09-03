import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Users.dart';
import 'package:flutter_application_1/models/config.dart';
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'package:email_validator/email_validator.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final _formkey = GlobalKey<FormState>();
  late Users user;

  Future<void> addNewUser(user) async {
    var url = Uri.http(Configure.server, "users");
    var resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()));
    var rs = usersFromJson("[${resp.body}]");
    if (rs.length == 1) {
      Navigator.pop(context, "refresh");
    }
    return;
  }

  Future<void> updateData(user) async {
    var url = Uri.http(Configure.server, "users/${user.id}");
    var resp = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()));
    var rs = usersFromJson("[${resp.body}]");
    if (rs.length == 1) {
      Navigator.pop(context, "refresh");
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    try {
      user = ModalRoute.of(context)!.settings.arguments as Users;
      print(user.fullname);
    } catch (e) {
      user = Users();
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          const Image(
            image: AssetImage('assets/images/okay.png'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double
                      .infinity, // ทำให้ Container ครอบคลุมทั้งความกว้างของหน้าจอ
                  height: 700,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Stack(children: [
                    Positioned(
                      top: 20,
                      left: 20,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_rounded),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 60, 30, 60),
                      child: Form(
                          key: _formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'Create new',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 44,
                                ),
                              ),
                              const Text(
                                'Account',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 44,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              const Text(
                                'Already registered? Log in here',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              fnameInputField(),
                              const SizedBox(
                                height: 30.0,
                              ),
                              emailInputField(),
                              const SizedBox(
                                height: 30.0,
                              ),
                              passwordInputField(),
                              const SizedBox(
                                height: 30.0,
                              ),
                              checkPassword(),
                              const SizedBox(
                                height: 30.0,
                              ),
                              SubmitButton(),
                            ],
                          )),
                    )
                  ])))
        ]));
  }

  Widget fnameInputField() {
    return TextFormField(
      initialValue: user.fullname,
      decoration: InputDecoration(
          fillColor: Color.fromARGB(255, 230, 224, 224),
          filled: true,
          labelText: "Name",
          hintText: "ใส่ชื่อที่นี่",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )),
      validator: (value) {
        if (value!.isEmpty) {
          return "กรุณาใส่ชื่อ";
        }
        return null;
      },
      // onSaved: (newValue) => email = newValue!,
      onSaved: (newValue) => user.fullname = newValue!,
    );
  }

  Widget emailInputField() {
    return TextFormField(
      initialValue: user.email,
      decoration: InputDecoration(
          fillColor: Color.fromARGB(255, 230, 224, 224),
          filled: true,
          labelText: 'Email',
          hintText: "ใส่อีเมลที่นี่",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )),
      validator: (value) {
        if (value!.isEmpty) {
          return "กรุณาป้อนอีเมล";
        }

        if (!EmailValidator.validate(value)) {
          return "คุณใส่อีเมลผิด";
        }
        return null;
      },
      // onSaved: (newValue) => email = newValue!,
      onSaved: (newValue) => user.email = newValue!,
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      initialValue: user.password,
      obscureText: true,
      decoration: InputDecoration(
          fillColor: Color.fromARGB(255, 230, 224, 224),
          filled: true,
          labelText: 'Password',
          hintText: "ใส่รหัสผ่านที่นี่",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )),
      validator: (value) {
        if (value!.isEmpty) {
          return "กรุณาป้อนรหัสผ่าน";
        }

        return null;
      },
      onSaved: (newValue) => user.password = newValue!,
    );
  }

  Widget checkPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          fillColor: Color.fromARGB(255, 230, 224, 224),
          filled: true,
          labelText: 'Check Password ',
          hintText: "ใส่รหัสผ่านอีกครั้ง",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )),
      validator: (value) {
        if (value!.isEmpty) {
          return "กรุณาป้อนรหัสผ่าน";
        }

        return null;
      },
    );
  }

  Widget SubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          print(user.toJson().toString());

          if (user.id == null) {
            addNewUser(user);
          } else {
            updateData(user);
          }
        }
      },
      child: Text('Sign Up'),
      style: customButtonStyle(),
    );
  }

  ButtonStyle customButtonStyle() {
    return ElevatedButton.styleFrom(
      primary: const Color.fromARGB(
          255, 96, 122, 167), // Set the button's background color
      onPrimary: Colors.white, // Set the button's text color
      textStyle: const TextStyle(fontSize: 18), // Set the text style
      padding: const EdgeInsets.symmetric(
          horizontal: 80, vertical: 12), // Set padding
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Set button border radius
      ),
    );
  }
}
