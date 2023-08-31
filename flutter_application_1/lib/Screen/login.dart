import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
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
          return welcome();
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),),
        
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.all(10),
        
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              emailInputField(),
              passwordInputField(),
              SubmitButton(),
              SizedBox(height: 20),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget emailInputField() {
    return TextFormField(
      initialValue: "phone@test.com",
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: "ใส่อีเมลที่นี่",
          icon: Icon(Icons.mark_email_read)),
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
      decoration: InputDecoration(
          labelText: 'Password',
          hintText: "ใส่รหัสผ่านที่นี่",
          icon: Icon(Icons.password)),
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
      child: Text("Login"),
    );
  }
  ButtonStyle customButtonStyle() {
  return ElevatedButton.styleFrom(
    primary: Colors.blueAccent, // Set the button's background color
    onPrimary: Colors.white, // Set the button's text color
    textStyle: TextStyle(fontSize: 18), // Set the text style
    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12), // Set padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // Set button border radius
    ),
  );
}
}