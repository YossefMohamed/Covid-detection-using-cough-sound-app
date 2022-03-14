import 'dart:convert';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid/config/palette.dart';
import 'package:covid/config/styles.dart';
import 'package:covid/modules/chart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/Tcases.dart';
import 'package:http/http.dart' as http;
import 'package:number_display/number_display.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class Tracker extends StatefulWidget {
  @override
  _Tracker createState() => _Tracker();
}

class _Tracker extends State<Tracker> {

  /// keep track of whatever user selection
  int flag = 0 , isGlobal = 0;

  /// covid data
  dynamic covid;

  /// Chart data
  final covidData = [12.17, 11.15, 10.02, 11.21, 13.83, 14.16, 14.30];

  /// max length to display 4
   final display = createDisplay(length: 4);
  /// ex: display(650000) = 650K

  /// global API data
  final String urlGlobal = "https://corona.lmao.ninja/v3/covid-19/all";

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

  /// init connection
  @override
  void initState() {
    super.initState();
    this.getJsonData();
    this.getJsonDataCountry();
    _getCurrentLocation();
  }

  /// Json Response for GLOBAL
  Future <Tcases> getJsonData() async
  {
      var response = await http.get(
      Uri.encodeFull(urlGlobal),
    );

    if (response.statusCode==200)
    {
      final convertDataJson = jsonDecode(response.body);

      return Tcases.fromJson(convertDataJson);
    }
    else{
      throw Exception('Check Connection and Try to Reload Page!');
    }
  }

  /// Country API data
  dynamic urlCountry = "https://corona.lmao.ninja/v3/covid-19/countries/";

  /// Json Response for COUNTRY
  Future <Tcases> getJsonDataCountry() async
  {
    var response = await http.get(
      Uri.encodeFull(urlCountry+li.first.replaceAll(' ', '')),
    );

    if (response.statusCode==200)
    {
      final convertDataJson = jsonDecode(response.body);

      return Tcases.fromJson(convertDataJson);
    }
    else{
      throw Exception('Check Connection and Try to Reload Page!');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Palette.primaryColor,

      body: CustomScrollView(

        /// tab bar and header
        physics: ClampingScrollPhysics(),

        slivers: <Widget>[
          _buildHeader(),
          _buildRegionTabBar(),
          _buildStatsTabBar(),

            /// Api related work
            SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  children: <Widget>[

                    /// fetch Api data and pass it to ui
                    FutureBuilder<Tcases>(

                        future: isGlobal == 0 ? getJsonData() : getJsonDataCountry(),
                        builder: (context, snapshot){

                          if(snapshot.hasData)
                          {
                             covid = snapshot.data;

                            return Column(
                              children: [
                                Row(
                                    children :  <Widget>[
                                                    Flexible(
                                                      child: Row(
                                                        children: <Widget>[
                                                          _buildStatCard('Total Cases', flag==1 ? display(covid?.todayCases)
                                                              : (flag==2 ? display(covid?.casesPerOneMillion) : display(covid?.cases)), Colors.orange),
                                                          _buildStatCard('Deaths', flag==1 ? display(covid?.todayDeaths)
                                                              : (flag==2 ? display(covid?.deathsPerOneMillion) : display(covid?.deaths)), Colors.red),
                                                        ],
                                                      ),
                                                    ),

                                    ]),
                                Row(
                                    children :  <Widget>[
                                      Flexible(
                                        child: Row(
                                          children: <Widget>[
                                            _buildStatCard('Recovered',  flag==1 ? display(covid?.todayRecovered)
                                                : (flag==2 ? display(covid?.recoveredPerOneMillion) : display(covid?.recovered)), Colors.pink),
                                            _buildStatCard('Active', flag==2 ? display(covid?.activePerOneMillion) : display(covid?.active), Colors.lightBlue),
                                            _buildStatCard('Critical', flag==2 ? display(covid?.criticalPerOneMillion) : display(covid?.critical), Colors.purple),
                                          ],
                                        ),
                                      ),

                                    ]),
                              ],
                            );

                          }
                          else if(snapshot.hasError)
                          {
                            return const Text('Check Connection and Try to Reload Page!');
                          }

                          return const CircularProgressIndicator();

                        }
                    ),

                  ],

                ),
              ),
            ),
          ),

           /// graph work
           SliverPadding(
            padding: EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: CovidBarChart(covidCases: covidData),
            ),
          ),

        ],

      ),

    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin:  EdgeInsets.all(5.0),
        padding:  EdgeInsets.all(7.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style:  const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style:  const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }


  /// header
  SliverPadding _buildHeader() {
    return  SliverPadding(
      padding: EdgeInsets.all(30.0),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Icon(Icons.menu,color: Colors.white,size: 30,),
                Icon(Icons.notifications,color: Colors.white,size: 30,),
              ],
            ),
            const Text(
              'Statistics',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),

          ],

        ),

      ),

    );

  }

  /// Tabbar for country
  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),

          child: TabBar(
            indicator: const BubbleTabIndicator(
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
            indicatorHeight: 40.0,
            indicatorColor: Colors.white,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.transparent,
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.white,
            tabs: const <Widget>[
              Text('Global'), // index 0
              Text('My Country'),
            ],
            onTap: (index) {
              isGlobal = index;
                 /// TODO after get user locatoin :)
                 /// display toast msg
//                 Fluttertoast.showToast(
//                   msg: li.first,
//                 );
            },
          ),
        ),
      ),
    );
  }

  /// Tabbar for states
  SliverPadding _buildStatsTabBar() {
    return SliverPadding(
      padding:  EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: DefaultTabController(
          length: 3,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: const <Widget>[
              Text('Total'),
              Text('Today'),
              Text('PerMilion'),
            ],
            onTap: (index) {
              flag = index;
              setState(() {});
            },
          ),
        ),
      ),
    );

  }
}






