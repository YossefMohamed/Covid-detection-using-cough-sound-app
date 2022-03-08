// @dart=2.9

import 'dart:io';
import 'package:flutter/material.dart';

import 'modules/main_page.dart';

void main() {
   runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'LeonSans'
      ),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

