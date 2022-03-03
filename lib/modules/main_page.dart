import 'package:covid/modules/Tracker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class MainPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.only(left: 16,top: 8,bottom: 6),
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
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            StatsScreen(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }

}