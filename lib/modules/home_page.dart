import 'dart:convert';

import 'package:covid/models/country.dart';
import 'package:covid/models/prevention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ///   for Prevention tips list
  List<Prevention> prevention = [
    Prevention(text: "Avoid close\ncontact", image: "assets/images/closecontact.jpeg"),
    Prevention(text: "Clean your\nhands often", image: "assets/images/hands.png"),
    Prevention(text: "Wear a\nfacemask", image: "assets/images/patient.png"),
  ];

Country con = new Country();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SingleChildScrollView(
       physics: const BouncingScrollPhysics(),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           Container(
             decoration: const BoxDecoration(
               color: Color(0xff28b463),
               borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
             ),
             child: Container(
               padding: const EdgeInsets.only(left: 20,right: 20),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   const SizedBox(height: 50,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: const <Widget>[
                       Icon(Icons.menu,color: Colors.white,size: 30,),
                       Icon(Icons.notifications,color: Colors.white,size: 30,),
                     ],

                   ),
                   const SizedBox(height: 30,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       const Text("Covid - 19",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),
                       Container(
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(30),
                         ),
                         padding: const EdgeInsets.only(left: 5,right: 16,top: 6,bottom: 6),
                               child: DropdownButtonHideUnderline(
                                 child: ButtonTheme(
                                   alignedDropdown: true,
                                   child: DropdownButton<String>(
                                     isDense: true,
                                     value: con.selected,
                                     onChanged: (String? newValue) {
                                       setState(() {
                                         con.selected = newValue!;
                                       });

                                     },
                                     items: con.myJson.map((Map map) {
                                       return DropdownMenuItem<String>(
                                         value: map["id"].toString(),
                                         child: Row(
                                           children: <Widget>[
                                             ClipRRect(
                                               borderRadius: BorderRadius.circular(30),
                                               child: Image.asset(
                                                 map["image"],
                                                 width: 25,
                                                 height: 25,
                                               ),
                                             ),

                                             Container(
                                                 margin: const EdgeInsets.only(left: 10),
                                                 child: Text(map["name"], style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),)),
                                           ],
                                         ),
                                       );
                                     }).toList(),
                                   ),
                                 ),
                               ),
                             ),

                     ],
                   ),
                   const SizedBox(height: 30,),
                   const Text("Are you feeling sick?",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),
                   const SizedBox(height: 20,),
                   const Text("If you feel sick with any of covid 19 symptoms\nplease call or SMS us immediately for help.",style: TextStyle(fontSize: 16,height: 1.6,color: Colors.white),),
                   const SizedBox(height: 30,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Container(
                         height: 45,
                         child: FlatButton(
                           onPressed: (){},
                           color: Colors.lightGreen,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(30),
                           ),
                           child: Container(
                             padding: EdgeInsets.only(left: 10,right: 10),
                             child: Row(
                               children: const <Widget>[
                                 Icon(Icons.call,color: Colors.white,),
                                 SizedBox(width: 10,),
                                 Text("Call Now",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),),
                               ],
                             ),
                           ),
                         ),
                       ),
                       const SizedBox(
                         width: 5.0,
                       ),
                       Container(
                         height: 45,
                         child: FlatButton(
                           onPressed: (){},
                           color: Colors.orangeAccent,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(30),
                           ),
                           child: Container(
                             padding: EdgeInsets.only(left: 10,right: 10),
                             child: Row(
                               children: const <Widget>[
                                 Icon(Icons.chat,color: Colors.white,),
                                 SizedBox(width: 10,),
                                 Text("Send SMS",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),),
                               ],
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),
                   SizedBox(height: 30,),
                 ],
               ),
             ),
           ),


           SizedBox(height: 30,),
           const Padding(
             padding: EdgeInsets.only(left: 20),
             child: Text("Prevention Tips",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
           ),
           SizedBox(height: 24,),
           Container(
             height: 120,
             child: ListView.builder(
               itemCount: prevention.length,
               shrinkWrap: true,
               physics: BouncingScrollPhysics(),
               scrollDirection: Axis.horizontal,
               padding: EdgeInsets.only(left: 20),
               itemBuilder: (context, index){
                 return Container(
                   padding: EdgeInsets.only(right: 60),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: <Widget>[
                       Image.asset(prevention[index].image,height: 50,width: 50,fit: BoxFit.cover,),
                       SizedBox(height: 10,),
                       Text(prevention[index].text,style: TextStyle(fontSize: 16,height: 1.5,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                     ],
                   ),
                 );
               },
             ),
           ),
           SizedBox(height: 20,),
           Container(
             margin: const EdgeInsets.only(left: 20,right: 20),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8),
               color: Color(0xff28b463),
             ),
             padding: EdgeInsets.all(16),
             child: Row(
               children: <Widget>[
                 Image.asset("assets/images/patient.png",height: 80,width: 80,),
                 const SizedBox(width: 24,),
                 Expanded(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: const <Widget>[
                       Text("Do your own test!",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
                       SizedBox(height: 10,),
                       Text("Follow the instructions to do your own test.",style: TextStyle(fontSize: 16,height: 1.5,color: Colors.white),),
                     ],
                   ),
                 ),
               ],
             ),
           ),
           const SizedBox(height: 30,)
         ],
       ),
     ),
   );
  }

}