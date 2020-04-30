import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/model/user.dart';



class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState(user);
}

class _HomePageState extends State<HomePage> {
  final User _user;

  _HomePageState(this._user);
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Container(child: Center(child: Text("Hoşgeldin${_user.userID}")),));
  }
}
