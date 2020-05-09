import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_bloc.dart';
import 'package:mucbirsebepler/locator.dart';
import 'package:mucbirsebepler/pages/splashScreen.dart';
import 'dart:io';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      SystemChrome.setEnabledSystemUIOverlays([]);
    }
    return MaterialApp(


      debugShowCheckedModeBanner: false,
      title: 'Mücbir Sebepler',
      theme: ThemeData(
        accentColor: Colors.lime,
        primarySwatch: Colors.deepOrange,
      ),
      home: BlocProvider(
          create: (context)=> AuthBloc(),
          child: SplashScreen()),
    );
  }
}
