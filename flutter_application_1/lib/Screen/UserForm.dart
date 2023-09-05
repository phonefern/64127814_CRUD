import 'dart:convert';
import 'package:flutter_application_1/models/Patients.dart';
import 'package:flutter_application_1/models/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => __UserFormState();
}

class __UserFormState extends State<UserForm> {
  final _formkey = GlobalKey<FormState>();
  late Patients patient;

  Future<void> addNewPatient(patient) async {
    var url = Uri.http(Configure.server, "patient");
    var resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(patient.toJson()));
    var rs = patientsFromJson("[${resp.body}]");
    if (rs.length == 1) {
      Navigator.pop(context, "refresh");
    }
    return;
  }

  Future<void> updatePatient(patient) async {
    var url = Uri.http(Configure.server, "patient/${patient.id}");
    var resp = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(patient.toJson()));
    var rs = patientsFromJson("[${resp.body}]");
    if (rs.length == 1) {
      Navigator.pop(context, "refresh");
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    try {
      patient = ModalRoute.of(context)!.settings.arguments as Patients;
      print(patient.fullname);
    } catch (e) {
      patient = Patients();
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            width: double
                .infinity, // ทำให้ Container ครอบคลุมทั้งความกว้างของหน้าจอ
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(children: [
              Positioned(
                top: 55,
                left: 20,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_sharp),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Form(key: _formkey,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 50, 30, 1),
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
                        Image.asset(
                          'assets/images/logo.png',
                          width: 300, // Set the desired width
                          height: 120,
                        ),
                        const SizedBox(height: 30.0),
                        const Text(
                          'ชื่อ - สกุล',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        fnameInputField(),
                        const SizedBox(height: 10.0),
                        const Text(
                          'HN',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        HNInputField(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'เพศ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  GenderInputField(),
                                ],
                              ),
                            ),
                            const SizedBox(
                                width:
                                    16.0), // Add spacing between Gender and Age
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'อายุ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  AgeInputField(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'อาการ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SymtomInputField(),
                        const SizedBox(height: 10.0),
                        const Text(
                          'โรคประจำตัว',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        DiseaseInputField(),
                        const SizedBox(height: 30.0),
                        Center(
                          child: SubmitButton(),
                        ),
                      ],
                    )),
              ),
            ])));
  }

  Widget fnameInputField() {
    return Container(
      height: 50, // Set the desired height
      child: TextFormField(
        initialValue: patient.fullname,
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 209, 206, 206),
          filled: true,
          labelText: "**โปรดระบุข้อมูล",
          hintText: "ใส่ชื่อที่นี่",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        style: const TextStyle(
          fontSize: 16, // Adjust the font size as needed
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "กรุณาใส่ชื่อ";
          }
          return null;
        },
        // onSaved: (newValue) => email = newValue!,
        onSaved: (newValue) => patient.fullname = newValue!,
      ),
    );
  }

// ignore: non_constant_identifier_names
  Widget HNInputField() {
    return Container(
        height: 50,
        child: TextFormField(
          initialValue: patient.hn,
          decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 209, 206, 206),
              filled: true,
              labelText: '**โปรดระบุข้อมูล เช่น 64127814',
              // hintText: "ใส่อีเมลที่นี่",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              )),
          // onSaved: (newValue) => email = newValue!,
          onSaved: (newValue) => patient.hn = newValue!,
        ));
  }

  // ignore: non_constant_identifier_names
  Widget GenderInputField() {
    return Container(
        height: 50,
        child: TextFormField(
          initialValue: patient.gender,
          decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 209, 206, 206),
              filled: true,
              labelText: '**โปรดระบุข้อมูล',
              // hintText: "ใส่อีเมลที่นี่",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              )),
          onSaved: (newValue) => patient.gender = newValue!,
        ));
  }

  Widget AgeInputField() {
    return Container(
        height: 45,
        child: TextFormField(
          initialValue: patient.age,
          decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 209, 206, 206),
              filled: true,
              labelText: '**โปรดระบุข้อมูล',
              // hintText: "ใส่อีเมลที่นี่",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              )),

          // onSaved: (newValue) => email = newValue!,
          onSaved: (newValue) => patient.age = newValue!,
        ));
  }

  Widget SymtomInputField() {
    return Container(
        height: 50,
        child: TextFormField(
          initialValue: patient.symptom,
          decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 209, 206, 206),
              filled: true,
              labelText: '**โปรดระบุข้อมูล',
              // hintText: "ใส่อีเมลที่นี่",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              )),

          // onSaved: (newValue) => email = newValue!,
          onSaved: (newValue) => patient.symptom = newValue!,
        ));
  }

  Widget DiseaseInputField() {
    return Container(
        height: 50,
        child: TextFormField(
          initialValue: patient.disease,
          decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 209, 206, 206),
              filled: true,
              labelText: '**โปรดระบุข้อมูล',
              // hintText: "ใส่อีเมลที่นี่",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              )),

          // onSaved: (newValue) => email = newValue!,
          onSaved: (newValue) => patient.disease = newValue!,
        ));
  }

  // ignore: non_constant_identifier_names
  Widget SubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          // ignore: avoid_print
          print(patient.toJson().toString());

          if (patient.id == null) {
            addNewPatient(patient);
          } else {
            updatePatient(patient);
          }
        }
      },
      style: customButtonStyle(),
      child: const Text(
        'Add Patient',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  ButtonStyle customButtonStyle() {
    return ElevatedButton.styleFrom(
      primary: const Color.fromARGB(
          255, 18, 135, 182), // Set the button's background color
      onPrimary: Colors.white, // Set the button's text color
      textStyle: const TextStyle(fontSize: 18), // Set the text style
      padding: const EdgeInsets.symmetric(
          horizontal: 70, vertical: 12), // Set padding
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Set button border radius
      ),
    );
  }
}
