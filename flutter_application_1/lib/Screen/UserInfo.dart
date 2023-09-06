import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Patients.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => __UserInfoState();
}

class __UserInfoState extends State<UserInfo> {
  final _formkey = GlobalKey<FormState>();
  late Patients patient;

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
              const Image(
            image: AssetImage('assets/images/gak.png'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
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
        readOnly: true,
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 209, 206, 206),
          filled: true,
          hintText: "ใส่ชื่อที่นี่",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        style: const TextStyle(
          fontSize: 16, // Adjust the font size as needed
        ),
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
          readOnly: true,
          decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 209, 206, 206),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              )),
        ));
  }

  // ignore: non_constant_identifier_names
  Widget GenderInputField() {
    return Container(
        height: 50,
        child: TextFormField(
          initialValue: patient.gender,
          readOnly: true,
          decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 209, 206, 206),
              filled: true,
              // hintText: "ใส่อีเมลที่นี่",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              )),
        ));
  }

  Widget AgeInputField() {
    return Container(
        height: 45,
        child: TextFormField(
          initialValue: patient.age,
          readOnly: true,
          decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 209, 206, 206),
              filled: true,
              // hintText: "ใส่อีเมลที่นี่",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              )),
        ));
  }

  Widget SymtomInputField() {
    return Container(
        height: 50,
        child: TextFormField(
          initialValue: patient.symptom,
          readOnly: true,
          decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 209, 206, 206),
              filled: true,
              // hintText: "ใส่อีเมลที่นี่",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              )),
        ));
  }

  Widget DiseaseInputField() {
    return Container(
        height: 50,
        child: TextFormField(
          initialValue: patient.disease,
          readOnly: true,
          decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 209, 206, 206),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              )),

        ));
  }
  }

