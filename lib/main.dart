import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cov ID',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.deepPurple,
      ),
      home: SplashScreens(),
    );
  }
}
class SplashScreens extends StatefulWidget {
  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(seconds: 3,
      navigateAfterSeconds: Home(),
      photoSize: 100,
      image: Image(image: AssetImage("assets/images/06.png"),),
      loadingText: Text("Cov_Id",style: TextStyle(fontSize:18,fontWeight:FontWeight.w600),),
      backgroundColor: Colors.white,
    );
  }
}


