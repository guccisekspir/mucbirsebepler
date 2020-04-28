import 'package:flutter/material.dart';
import 'package:mucbirsebepler/pages/homePage.dart';
import 'package:mucbirsebepler/pages/loginPage.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogged = false;
  @override
  Widget build(BuildContext context) {
    if(isLogged){
      return HomePage();
    }
    else{
      return LoginPage();
    }
  }
}
