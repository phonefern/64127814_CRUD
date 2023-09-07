// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/UserForm.dart';
import 'package:flutter_application_1/Screen/UserInfo.dart';
import 'package:flutter_application_1/Screen/login.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/Patients.dart';
import 'package:flutter_application_1/models/Users.dart';
import 'package:flutter_application_1/models/config.dart';
import 'package:google_fonts/google_fonts.dart';
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
    super.initState();
    Users user = Configure.login;
     shuffledImageUrls = List.from(imageUrls)..shuffle();
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
        title:  Text("Patient",
            style: GoogleFonts.poppins(
                fontSize: 25,
                 color: Colors.black,
                  fontWeight: FontWeight.bold),
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
// สร้างรายการ URL ของรูปภาพที่จะใช้
List<String> imageUrls = [
  "https://cdn.pixabay.com/photo/2016/11/21/12/42/beard-1845166_1280.jpg",
  "https://cdn.pixabay.com/photo/2015/01/27/09/58/man-613601_1280.jpg",
  "https://media.istockphoto.com/id/1289220545/th/%E0%B8%A3%E0%B8%B9%E0%B8%9B%E0%B8%96%E0%B9%88%E0%B8%B2%E0%B8%A2/%E0%B8%9C%E0%B8%B9%E0%B9%89%E0%B8%AB%E0%B8%8D%E0%B8%B4%E0%B8%87%E0%B8%AA%E0%B8%A7%E0%B8%A2%E0%B8%A2%E0%B8%B4%E0%B9%89%E0%B8%A1%E0%B8%94%E0%B9%89%E0%B8%A7%E0%B8%A2%E0%B9%81%E0%B8%82%E0%B8%99%E0%B9%84%E0%B8%82%E0%B8%A7%E0%B9%89.jpg?s=2048x2048&w=is&k=20&c=KDZk-QigVeHP72lsXf3ITsMPwoFoJojVAOECB0WG2yQ=",
  "https://media.istockphoto.com/id/1408041355/th/%E0%B8%A3%E0%B8%B9%E0%B8%9B%E0%B8%96%E0%B9%88%E0%B8%B2%E0%B8%A2/%E0%B8%99%E0%B8%B1%E0%B8%81%E0%B8%98%E0%B8%B8%E0%B8%A3%E0%B8%81%E0%B8%B4%E0%B8%88%E0%B8%AB%E0%B8%8D%E0%B8%B4%E0%B8%87%E0%B8%9C%E0%B8%B4%E0%B8%A7%E0%B8%94%E0%B9%8D%E0%B8%B2%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B8%A1%E0%B8%B5%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A1%E0%B8%AA%E0%B8%B8%E0%B8%82%E0%B9%82%E0%B8%94%E0%B8%A2%E0%B9%83%E0%B8%8A%E0%B9%89%E0%B8%AA%E0%B8%A1%E0%B8%B2%E0%B8%A3%E0%B9%8C%E0%B8%97%E0%B9%82%E0%B8%9F%E0%B8%99%E0%B9%83%E0%B8%99%E0%B8%AA%E0%B9%8D%E0%B8%B2%E0%B8%99%E0%B8%B1%E0%B8%81%E0%B8%87%E0%B8%B2%E0%B8%99%E0%B8%AA%E0%B8%A3%E0%B9%89%E0%B8%B2%E0%B8%87%E0%B8%AA%E0%B8%A3%E0%B8%A3%E0%B8%84%E0%B9%8C.jpg?s=612x612&w=0&k=20&c=fOrI3yR9r6WNVWQCtsWqcJ-2YWENddVoDM3ZJWirqPg=",
  "https://media.istockphoto.com/id/1389465862/th/%E0%B8%A3%E0%B8%B9%E0%B8%9B%E0%B8%96%E0%B9%88%E0%B8%B2%E0%B8%A2/%E0%B8%A0%E0%B8%B2%E0%B8%9E%E0%B8%99%E0%B8%B1%E0%B8%81%E0%B8%98%E0%B8%B8%E0%B8%A3%E0%B8%81%E0%B8%B4%E0%B8%88%E0%B8%AB%E0%B8%99%E0%B8%B8%E0%B9%88%E0%B8%A1%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B8%97%E0%B9%8D%E0%B8%B2%E0%B8%87%E0%B8%B2%E0%B8%99%E0%B8%9A%E0%B8%99%E0%B9%81%E0%B8%A5%E0%B9%87%E0%B8%9B%E0%B8%97%E0%B9%87%E0%B8%AD%E0%B8%9B%E0%B8%82%E0%B8%AD%E0%B8%87%E0%B9%80%E0%B8%82%E0%B8%B2%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B9%82%E0%B8%95%E0%B9%8A%E0%B8%B0%E0%B8%97%E0%B9%8D%E0%B8%B2%E0%B8%87%E0%B8%B2%E0%B8%99%E0%B8%82%E0%B8%AD%E0%B8%87%E0%B9%80%E0%B8%82%E0%B8%B2.jpg?s=612x612&w=0&k=20&c=Sl7-RpkuOBa6K-bMXixW2NwSPVlVTECsQNthzihvfhM=",
  "https://media.istockphoto.com/id/1296344118/th/%E0%B8%A3%E0%B8%B9%E0%B8%9B%E0%B8%96%E0%B9%88%E0%B8%B2%E0%B8%A2/%E0%B8%9C%E0%B8%B9%E0%B9%89%E0%B8%AB%E0%B8%8D%E0%B8%B4%E0%B8%87%E0%B8%A1%E0%B8%B5%E0%B8%84%E0%B8%A7%E0%B8%B2%E0%B8%A1%E0%B8%AA%E0%B8%B8%E0%B8%82%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B8%AA%E0%B8%A7%E0%B8%A2%E0%B8%87%E0%B8%B2%E0%B8%A1%E0%B9%80%E0%B8%9E%E0%B8%A5%E0%B8%B4%E0%B8%94%E0%B9%80%E0%B8%9E%E0%B8%A5%E0%B8%B4%E0%B8%99%E0%B8%81%E0%B8%B1%E0%B8%9A%E0%B9%81%E0%B8%AA%E0%B8%87%E0%B9%81%E0%B8%94%E0%B8%94%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B8%AD%E0%B8%9A%E0%B8%AD%E0%B8%B8%E0%B9%88%E0%B8%99%E0%B9%83%E0%B8%99%E0%B8%AA%E0%B8%A7%E0%B8%99%E0%B8%AA%E0%B8%B2%E0%B8%98%E0%B8%B2%E0%B8%A3%E0%B8%93%E0%B8%B0%E0%B9%80%E0%B8%82%E0%B8%95%E0%B8%A3%E0%B9%89%E0%B8%AD%E0%B8%99.jpg?s=612x612&w=0&k=20&c=KNUg6dOM0CFPwEML51Mb65qxI0cLbZjh3eN9LHPcB9I=",
  "https://media.istockphoto.com/id/1301592466/th/%E0%B8%A3%E0%B8%B9%E0%B8%9B%E0%B8%96%E0%B9%88%E0%B8%B2%E0%B8%A2/%E0%B8%9C%E0%B8%B9%E0%B9%89%E0%B8%8A%E0%B8%B2%E0%B8%A2%E0%B9%81%E0%B8%AD%E0%B8%9F%E0%B8%A3%E0%B8%B4%E0%B8%81%E0%B8%B1%E0%B8%99%E0%B8%9A%E0%B8%A7%E0%B8%81%E0%B8%95%E0%B8%B0%E0%B9%82%E0%B8%81%E0%B8%99%E0%B9%83%E0%B8%99%E0%B9%82%E0%B8%97%E0%B8%A3%E0%B9%82%E0%B8%82%E0%B9%88%E0%B8%87%E0%B8%A1%E0%B8%B2%E0%B8%81%E0%B8%81%E0%B8%A7%E0%B9%88%E0%B8%B2%E0%B8%9E%E0%B8%B7%E0%B9%89%E0%B8%99%E0%B8%AB%E0%B8%A5%E0%B8%B1%E0%B8%87%E0%B8%AA%E0%B8%B5%E0%B9%80%E0%B8%97%E0%B8%B2.jpg?s=612x612&w=0&k=20&c=Gj-r5-DefpbIpYmB9pMDphLO4B1uZ75d5bEN-qhP4yM=",
  // เพิ่ม URL อื่น ๆ ตามต้องการ
];

List<String> shuffledImageUrls = [];

String getNextImageUrl() {
    if (shuffledImageUrls.isEmpty) {
      // สุ่มรายการใหม่เมื่อครบทุกรูปภาพ
      shuffledImageUrls = List.from(imageUrls)..shuffle();
    }
    return shuffledImageUrls.removeLast();
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
                    20, 25, 20, 20), // ปรับแต่ง Padding ตามความต้องการ
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30, // ขนาดของวงกลม
                   backgroundImage: NetworkImage(getNextImageUrl()),
                  ),
                  title: Text(
                    '0${patient.id}  ${patient.fullname}', // เชื่อม id และ fullname ในบรรทัดเดียวกัน
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
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
                    icon: const Icon(Icons.edit),
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
