import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_bloc.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_state.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
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
    // ignore: close_sinks
    AuthBloc _authBloc=BlocProvider.of<AuthBloc>(context);

    // ignore: missing_return
    BlocBuilder(bloc: _authBloc,builder: (context,state){
      if(state is AuthLoadedState){
        isLogged=true;
      }
    },);
    if(isLogged){
      return HomePage();
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
