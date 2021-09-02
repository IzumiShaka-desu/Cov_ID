// import 'package:Cov_id/api/api_repository.dart';
// import 'package:Cov_id/pages/dashboard.dart';
// import 'package:Cov_id/pages/stat.dart';
// import 'package:Cov_id/pages/what.dart';
import 'package:Cov_id/api/api_provider.dart';
import 'package:Cov_id/pages/stat.dart';
import 'package:Cov_id/pages/what.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
 VoidCallback toStat;
  int currentTab = 0;
  PageStorageBucket _pageBucket = PageStorageBucket();
  @override
  void initState(){
    
   super.initState();

  }
 Widget currentScreen;
  @override
  Widget build(BuildContext context) {
    
  switch(currentTab){
    case 0:currentScreen=Dashboard();
            break;
    case 1:currentScreen=What();
            break;
    case 2:currentScreen=Stat();
            break;
    default:currentScreen=Dashboard();
            break;
  }
  ApiProvider().getDataGrowthAsync();
    return ChangeNotifierProvider<ApiProvider>(
          create:(context)=>ApiProvider(),
          
          child:Scaffold(
        body: PageStorage(bucket: _pageBucket, child: currentScreen),
        floatingActionButton: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: currentTab == 1 ? Colors.purpleAccent : Colors.white10,
                spreadRadius: 5,
                blurRadius: 5)
          ], color: Colors.yellow, shape: BoxShape.circle),
          child: FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
            child: Center(
              child: Text("?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45)),
            ),
            onPressed: () {
              setState(() {
                currentTab = 1;
              });
            },
            splashColor: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
            notchMargin: 40,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(color: currentTab == 0
                          ? Colors.deepPurpleAccent
                          : Colors.white,
                        borderRadius:BorderRadius.all(Radius.circular(40))
                      ),
                      child: MaterialButton(
                        elevation: 0,
                        color: Colors.white,
                        height: 50,
                        child: Icon(
                          Icons.home,
                          size:30,
                           color: currentTab==0?Colors.deepPurple:Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            currentTab = 0;
                          });
                        },
                      ),
                    ),
                     Container(
                      padding: EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(color: currentTab == 2
                          ? Colors.deepPurpleAccent
                          : Colors.white,
                        borderRadius:BorderRadius.all(Radius.circular(40))
                      ),
                      
                      child: MaterialButton(
                        elevation: 0,
                        color: Colors.white,
                        height: 50,
                        child: Icon(
                          Icons.insert_chart,
                          size: 30,
                          color: currentTab==2?Colors.deepPurple:Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            currentTab = 2;
                          });
                        },
                      ),
                    ),
                  ]),
            )),
      ),
    );
  }
}
