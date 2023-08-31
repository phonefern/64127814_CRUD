
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile.dart';
// ignore: unused_import
import 'package:form_field_validator/form_field_validator.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final formkey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');
  // final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    
      
       
          return Scaffold(
        appBar: AppBar(
          title: Text("สร้างบัญชีผู้ใช้งาน"),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("อีเมล", style: TextStyle(fontSize: 20)),
                  TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: "กรุณากรอกอีเมล"),
                      EmailValidator(errorText: "รูปเเบบอีเมลไม่ถูกต้อง")
                    ]),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (String? email) {
                      // Update the parameter type to String?
                      if (email != null) {
                        profile.email = email;
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("รหัสผ่าน", style: TextStyle(fontSize: 20)),
                  TextFormField(
                    validator: RequiredValidator(errorText: "กรุณากรอกรหัสผ่าน"),
                    obscureText: true,
                    onSaved: (String? password) {
                      // Update the parameter type to String?
                      if (password != null) {
                        profile.password = password;
                      }
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        child:
                            Text("ลงทะเบียน", style: TextStyle(fontSize: 20)),
                        onPressed: () {
                          // formkey.currentState?.save();
                          // print("email = ${profile.email} password = ${profile.password}");
                          // formkey.currentState?.reset();
                          if(formkey.currentState!.validate()) {
                            formkey.currentState?.save();
                            print("email = ${profile.email} password = ${profile.password}");
                            formkey.currentState?.reset();
                          }
                        }),
                  ),
                ],
              )),
        ));
        }
        
          
      
    
    
  }

