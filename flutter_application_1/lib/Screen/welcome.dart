import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/UserForm.dart';
import 'package:flutter_application_1/Screen/UserInfo.dart';
import 'package:flutter_application_1/Screen/login.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/Users.dart';
import 'package:flutter_application_1/models/config.dart';
import 'package:http/http.dart' as http;

class welcome extends StatefulWidget {
  static String routeName = "/";
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  Widget mainbody = Container();
  Future<void> removeUsers(user) async {
    var url = Uri.http(Configure.server, "users/${user.id}");
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
      getUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome"),
        ),
        drawer: Sidemenu(),
        body: mainbody,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String result = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserForm()));
          if (result == "refresh") {
            getUsers();
          }
          },
          child: Icon(Icons.person_add_alt_1),
        ));
  }


  Widget showUsers() {
    return ListView.builder(
      itemCount: _userList.length,
      itemBuilder: (context, index) {
        Users user = _userList[index];
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            removeUsers(user);
          },
          background: Container(
            color: Colors.red,
            margin: EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete, color: Colors.white),
            
          ),
          
          
          child: Card(
            child: ListTile(
              title: Text("${user.fullname}"),
              subtitle: Text("HN: ${user.hn}"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserInfo(),
                        settings: RouteSettings(arguments: user)));
              },
              trailing: IconButton(
                onPressed: () async {
                  String result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserForm(),
                          settings: RouteSettings(arguments: user)));
                  if (result == "refresh") {
                    getUsers();
                  }
                },
                icon: Icon(Icons.edit),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Users> _userList = [];
  Future<void> getUsers() async {
    var url = Uri.http(Configure.server, "users");
    var resp = await http.get(url);
    setState(() {
      _userList = usersFromJson(resp.body);
      mainbody = showUsers();
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
        UserAccountsDrawerHeader(
          accountName: Text(accountName),
          accountEmail: Text(accountEmail),
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage(accountpic),
            backgroundColor: Colors.white,
          ),
        ),
        ListTile(
          leading: Icon(Icons.home_max_sharp),
          title: Text("Home"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return welcome();
            }));
          },
        ),
        ListTile(
          leading: Icon(Icons.login_sharp),
          title: Text("Login"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoginScreen();
            }));
          },
        ),
        ListTile(
          leading: Icon(Icons.logout_sharp),
          title: Text("logout"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return start();
            }));
          },
        )
      ],
    ));
  }
}
