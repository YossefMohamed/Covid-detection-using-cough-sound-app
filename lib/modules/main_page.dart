import 'package:covid/modules/LoginScreen.dart';
import 'package:covid/modules/Tracker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  // track user status
  bool signed = false;

  @override
  Widget build(BuildContext context) {
  return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
          SystemUiOverlayStyle.light, // status bar text to light :)
          backgroundColor: Color(0xff28b463),
          elevation: 0,
          // check user status
          leading:  checkUserStatus()
              ?
          // logout
          IconButton(

              icon: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 30,
              ),

              onPressed: () {
                try{
                   FirebaseAuth.instance.signOut();
                  Fluttertoast.showToast(
                    msg: 'Sign Out Successfully',
                  );
                }on FirebaseAuthException catch(e){
                  Fluttertoast.showToast(
                    msg: e.message.toString(),
                  );
                }

              })
              :
          // login
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: const Icon(
                Icons.login,
                color: Colors.white,
                size: 30,
              )
          ),

          actions: [
            myAppBarIcon(),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            Tracker(),
            Container(),
            Container(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 6),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey.shade300,
              indicator: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(40),
              ),
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.home),
                ),
                Tab(
                  icon: Icon(Icons.assessment),
                ),
                Tab(
                  icon: Icon(Icons.supervised_user_circle),
                ),
                Tab(
                  icon: Icon(Icons.help),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // custom appbar
  Widget myAppBarIcon() {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Container(
        width: 30,
        height: 30,
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Icon(
                Icons.notifications,
                color: Colors.white,
                size: 30,
              ),
            ),
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 12),
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xffc32c37),
                    border: Border.all(color: Colors.white, width: 1)),
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Center(
                    child: Text(
                      '2',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // check user status
  // TODO: solve bug of non switch states of login / logout
  checkUserStatus(){
      setState(() {
        FirebaseAuth.instance.userChanges().listen((User? user) {
          signed =  (user == null) ? false : true;
        });
      });
      return signed;
  }

}
