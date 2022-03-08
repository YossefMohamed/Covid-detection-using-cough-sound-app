//import 'package:flutter/material.dart';
//
//class StatsGrid extends StatelessWidget {
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: MediaQuery.of(context).size.height * 0.25,
//      child: Column(
//        children: <Widget>[
//          Flexible(
//            child: Row(
//              children: <Widget>[
//                _buildStatCard('Total Cases', this._x, Colors.orange),
//                _buildStatCard('Deaths', this._y, Colors.red),
//              ],
//            ),
//          ),
//          Flexible(
//            child: Row(
//              children: <Widget>[
//                _buildStatCard('Recovered', '13.2k', Colors.pink),
//                _buildStatCard('Active', '1.81 M', Colors.lightBlue),
//                _buildStatCard('Critical', 'N/A', Colors.purple),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Expanded _buildStatCard(String title, String count, MaterialColor color) {
//    return Expanded(
//      child: Container(
//        margin:  EdgeInsets.all(5.0),
//        padding:  EdgeInsets.all(7.0),
//        decoration: BoxDecoration(
//          color: color,
//          borderRadius: BorderRadius.circular(10.0),
//        ),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Text(
//              title,
//              style:  TextStyle(
//                color: Colors.white,
//                fontSize: 15.0,
//                fontWeight: FontWeight.w600,
//              ),
//            ),
//            Text(
//              count,
//              style:  TextStyle(
//                color: Colors.white,
//                fontSize: 20.0,
//                fontWeight: FontWeight.bold,
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}