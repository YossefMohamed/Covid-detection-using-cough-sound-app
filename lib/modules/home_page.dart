import 'dart:convert';

import 'package:covid/models/prevention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity/connectivity.dart';


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
    Prevention(text: "Avoid using\nyour hand", image: "assets/images/avoid.png"),
    Prevention(text: "Wear a\nfacemask", image: "assets/images/patient.png"),
    Prevention(text: "See a doctor\nif needed", image: "assets/images/doc.png"),

  ];

  /// check for types of connection wifi-mobile data, use it if needed
  var wifiBSSID;
  var wifiIP;
  var wifiName;
  bool iswificonnected = false;
  bool isInternetOn = true;


late final List<String> li =  ['country-name'];

  /// Determine the current position of the device.
  late Position position;

  void _getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
           print("Permission Denied");
        });
      }else{
        var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
          final coordinates = Coordinates(position.latitude, position.longitude);
          var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
          var first = addresses.first;
          //first.featureName+' '+
          var country = first.addressLine.split(',').last; // country name
          li.remove(li.last);
          li.add(country);
          setState(() {});
      }
    }else{
      var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        final coordinates = Coordinates(position.latitude, position.longitude);
        var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        // first.featureName
        var country = first.addressLine.split(',').last; // country name
         li.remove(li.last);
        li.add(country);
        setState(() {});
    }
  }

/// start connection and gps loc
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    GetConnect(); // calls getconnect method to check which type if connection it
  }

  /// display no connection msg
  AlertDialog buildAlertDialog() {
    return const AlertDialog(
      title: Text(
        "Your device has no connection\nPlease connect and reload page",
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }

  /// internet connection
  void GetConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isInternetOn = false;
      });
    } else if (connectivityResult == ConnectivityResult.mobile) {
      iswificonnected = false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      iswificonnected = true;
      setState(() async {
        wifiBSSID = await (Connectivity().getWifiBSSID());
        wifiIP = await (Connectivity().getWifiIP());
        wifiName = await (Connectivity().getWifiName());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(

//       appBar: AppBar(
//         backgroundColor: Color(0xff28b463),
//         elevation: 0,
//         leading: const Icon(Icons.menu,color: Colors.white,size: 30,),
//         actions: const [
//           Icon(Icons.notifications,color: Colors.white,size: 30,),
//         ],
//       ),

     body:  isInternetOn ? SingleChildScrollView(
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
                             child: Row(
                               children:  [

                                 const Icon(
                                   Icons.location_on,
                                   color: Colors.green,
                                 ),

                                 SizedBox(width: 5.0,),
                                 Text(
                                   li.first,
                                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                                 ),

                               ],
                             ),
                             ),


                     ],
                   ),
                   const SizedBox(height: 30,),
                   const Text("Are You Feeling Sick?",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),
                   const SizedBox(height: 10,),
                   const Text("Click Below To Make Test or Scroll Down For Your Government Help.",style: TextStyle(fontSize: 16,height: 1.6,color: Colors.white),),
                   const SizedBox(height: 30,),

                 ],
               ),
             ),
           ),
           SizedBox(height: 20,),
           GestureDetector(
             child: Container(
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

             onTap: (){
                openDialog();
             },
           ),

           const SizedBox(height: 30,),
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

           const SizedBox(height: 30,),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Container(
                 height: 70.0,
                 child: FlatButton(
                   onPressed: (){},
                   color: Color(0xff28b463),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(20),
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
                 height: 70.0,
                 child: FlatButton(
                   onPressed: (){},
                   color: Colors.blue,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(20),
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
           const SizedBox(height: 30,),

         ],

       ),
     ) : buildAlertDialog(),

   );

  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xff28b463),
          title: const Text(
            'Record Your Cough Sound',
            style: TextStyle(color: Colors.white),
          ),
        content: const Icon(
             Icons.mic,
          color: Colors.white,
        ),
        actions: [
           TextButton(
               onPressed: exit,
               child: Text('EXIT',style: TextStyle(color:Colors.white),),

           ),
        ],
      ),
  );

  // close the pop up
  void exit(){
    Navigator.of(context).pop();
  }

}