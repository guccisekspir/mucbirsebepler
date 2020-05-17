import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_bloc.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_state.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/pages/homePage.dart';
import 'package:mucbirsebepler/pages/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isLogged = false;

  Future<Null> _function() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    this.setState(() {
      if (prefs.getString("userID") != null) {
        isLogged = true;
      } else {
        isLogged = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _function();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    if(isLogged){
      return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(create: (context)=>AuthBloc(),),
            BlocProvider<DataBaseBloc>(create: (context)=>DataBaseBloc(),)
          ],
          child: HomePage(isLogged: true,));
    }
    else{
      return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(create: (context)=>AuthBloc(),),
            BlocProvider<DataBaseBloc>(create: (context)=>DataBaseBloc(),)
          ],
          child: LoginPage());
    }
  }
}
