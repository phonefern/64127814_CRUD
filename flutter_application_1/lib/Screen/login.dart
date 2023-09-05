import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_application_1/Screen/register.dart';
import 'package:flutter_application_1/Screen/welcome.dart';
import 'package:flutter_application_1/models/Users.dart';
import 'package:flutter_application_1/models/config.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        hintColor: Colors.black,
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  Users user = Users();
  bool isChecked = false;

  // String email = "";
  // String password = "";

  Future<void> login(Users user) async {
    var parameter = {"email": "phone@test.com", "password": "123456"};
    var url = Uri.http(Configure.server, "users", parameter);
    // var url = Uri.http("10.116.2.219:3000", "users", parameter);
    var resp = await http.get(url);
    print(resp.body);

    List<Users> loginResult = usersFromJson(resp.body);
    if (loginResult.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("คุณใส่อีเมลหรือพาสเวิสผิด")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ยินดีต้อนคุณเข้าสู่ระบบเเล้ว")));
      Configure.login = loginResult[0];
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return const welcome();
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/images/okay.png'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity, // ทำให้ Container ครอบคลุมทั้งความกว้างของหน้าจอ
              height: 535,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 30, 30, 20),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.normal,
                          fontSize: 50,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Sign in to continue.',
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 20),
                      emailInputField(),
                      const SizedBox(height: 20),
                      passwordInputField(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Remember Me",
                            style: TextStyle(color: Colors.black),
                          ),
                          Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              isChecked = !isChecked;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SubmitButton(),
                      TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xff4c505b),
                                fontSize: 18,
                              ),
                            ),
                          ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const Registerscreen();
                              }));
                            },
                            style: const ButtonStyle(),
                            child: const Text(
                              'Sign Up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xff4c505b),
                                fontSize: 18,
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emailInputField() {
    return TextFormField(
      initialValue: "phone@test.com",
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 230, 224, 224),
        filled: true,
          labelText: 'Email',
          hintText: "ใส่อีเมลที่นี่",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )
          ),
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
      initialValue: "123456",
      obscureText: true,
      decoration:  InputDecoration(
        fillColor: const Color.fromARGB(255, 230, 224, 224),
        filled: true,
          labelText: 'Password',
          hintText: "ใส่รหัสผ่านที่นี่",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )
          ),
      validator: (value) {
        if (value!.isEmpty) {
          return "กรุณาป้อนรหัสผ่าน";
        }

        return null;
      },
      onSaved: (newValue) => user.password = newValue!,
    );
  }

  Widget SubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("กำลังเชื่อมต่อ")),
          );
          // print("${email} ${password}");
          print(user.toJson().toString());
          // loginState(email, password);
          login(user);
        }
      },
      style: customButtonStyle(),
      child: const Text("Login"),
    );
  }

  ButtonStyle customButtonStyle() {
    return ElevatedButton.styleFrom(
      primary: const Color.fromARGB(255, 53, 140, 197),  // Set the button's background color
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
