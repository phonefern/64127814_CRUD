import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/UserForm.dart';
import 'package:flutter_application_1/Screen/UserInfo.dart';
import 'package:flutter_application_1/Screen/login.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/Patients.dart';
import 'package:flutter_application_1/models/Users.dart';
import 'package:flutter_application_1/models/config.dart';
import 'package:http/http.dart' as http;
import 'package:dotted_line/dotted_line.dart';

class welcome extends StatefulWidget {
  static String routeName = "/";
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  Widget mainbody = Container();
  Future<void> removeUsers(patient) async {
    var url = Uri.http(Configure.server, "patient/${patient.id}");
    var resp = await http.delete(url);
    print(resp.body);
    return;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Users user = Configure.login;
    if (user.id != null) {
      // mainbody = showUsers();
      getPatients();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 71, 177, 238),
        title: const Text("Patient",
            style: TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center), // ข้อความอยู่ตรงกลาง
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person_add_alt_1),
            onPressed: () async {
              String result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const UserForm()));
              if (result == "refresh") {
                getPatients();
              }
            },
          ),
        ],
      ),
      drawer: const Sidemenu(),
      body: mainbody,
    );
  }

  Widget showPatients() {
    return ListView.builder(
      itemCount: _patientList.length + 1, // เพิ่ม 1 เพื่อให้มีข้อความด้านบนสุด
      itemBuilder: (context, index) {
        if (index == 0) {
          // สร้างข้อความด้านบนสุด
          return const Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "ID",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "All Patient",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 1),
                  child: Divider(
                    thickness: 6,
                    color: Color.fromARGB(255, 87, 154, 209),
                  ),
                )
              ],
            ),
          );
        }
        Patients patient = _patientList[index - 1];
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            removeUsers(patient);
          },
          background: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(
                  10), // ปรับค่าตรงนี้เพื่อเปลี่ยนความโค้ง
            ),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    20, 20, 20, 20), // ปรับแต่ง Padding ตามความต้องการ
                child: ListTile(
                  leading: Image.asset(
                    "assets/images/user.png",
                    width: 40,
                    height: 40,
                  ),
                  title: Text(
                    '0${patient.id}  ${patient.fullname}', // เชื่อม id และ fullname ในบรรทัดเดียวกัน
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text("HN:     ${patient.hn}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserInfo(),
                        settings: RouteSettings(arguments: patient),
                      ),
                    );
                  },
                  trailing: IconButton(
                    onPressed: () async {
                      String result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserForm(),
                          settings: RouteSettings(arguments: patient),
                        ),
                      );
                      if (result == "refresh") {
                        getPatients();
                      }
                    },
                    icon: const Icon(Icons.edit_attributes_sharp),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(25, 1, 25, 1),
                child: DottedLine(
                  dashColor: Color.fromARGB(255, 0, 149, 194), // สีของเส้นประ
                  dashGapLength: 5.0, // ความยาวระหว่างเส้นประแท็บ
                  dashLength: 15.0, // ความยาวของแต่ละเส้นประ
                  lineThickness: 3.0, // ความหนาของเส้นประ
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Patients> _patientList = [];
  Future<void> getPatients() async {
    var url = Uri.http(Configure.server, "patient");
    var resp = await http.get(url);
    setState(() {
      _patientList = patientsFromJson(resp.body);
      mainbody = showPatients();
    });
    return;
  }
}

class Sidemenu extends StatelessWidget {
  const Sidemenu({super.key});

  @override
  Widget build(BuildContext context) {
    String accountName = "N/A";
    String accountEmail = "N/A";
    String accountpic = 'assets/images/book.jpg';

    Users user = Configure.login;
    print(user.toJson().toString());
    if (user.id != null) {
      accountName = user.fullname!;
      accountEmail = user.email!;
    }

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 250, // ส่วนสูงของ UserAccountsDrawerHeader
            child: Align(
              alignment: Alignment
                  .center, // จัดวาง UserAccountsDrawerHeader อยู่ตรงกลาง
              child: UserAccountsDrawerHeader(
                accountName: Text(accountName),
                accountEmail: Text(accountEmail),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage(accountpic),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.home_max_sharp),
                  title: const Text("Home"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const welcome();
                    }));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.login_sharp),
                  title: const Text("Login"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout_sharp),
                  title: const Text("Logout"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const start();
                    }));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
