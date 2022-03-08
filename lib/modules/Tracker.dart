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

class Tracker extends StatefulWidget {
  @override
  _Tracker createState() => _Tracker();
}

class _Tracker extends State<Tracker> {

  /// keep track of whatever user selection
  int flag = 0;

  /// covid data
  dynamic covid;

  /// Chart data
  final covidData = [12.17, 11.15, 10.02, 11.21, 13.83, 14.16, 14.30];

  /// max length to display 4
   final display = createDisplay(length: 4);
  /// ex: display(650000) = 650K

  /// global API data
  final String urlGlobal = "https://corona.lmao.ninja/v3/covid-19/all";

  /// global API data
   //final String url_country = "https://corona.lmao.ninja/v3/covid-19/countries/cuntry_name";

  /// init connection
  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  /// Json Response
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

                        future: getJsonData(),
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
                                                              : (flag==2 ? display(covid?.todayCases) : display(covid?.cases)), Colors.orange),
                                                          _buildStatCard('Deaths', flag==1 ? display(covid?.todayDeaths)
                                                              : (flag==2 ? display(covid?.todayDeaths) : display(covid?.deaths)), Colors.red),
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
                                                : (flag==2 ? display(covid?.todayRecovered) : display(covid?.recovered)), Colors.pink),
                                            _buildStatCard('Active', display(covid?.active), Colors.lightBlue),
                                            _buildStatCard('Critical', display(covid?.critical), Colors.purple),
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
              Text('Global'),
              Text('My Country'),
            ],
            onTap: (index) {
                 /// TODO after get user locatoin :)
                 /// display toast msg
                 Fluttertoast.showToast(
                   msg: index.toString(),
                 );
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
              Text('Yesterday'),
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






