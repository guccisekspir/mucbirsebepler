import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_bloc.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/bloc/postbloc/bloc.dart';
import 'package:mucbirsebepler/model/user.dart';


class ProfilePage extends StatefulWidget {
  final User gelenUser;

  const ProfilePage({Key key, this.gelenUser}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DataBaseBloc _dataBaseBloc;
  @override
  void initState() {
    _dataBaseBloc=BlocProvider.of<DataBaseBloc>(context);
    _dataBaseBloc.add(GetUserr(userID: widget.gelenUser.userID));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(widget.gelenUser.userName),),
    );
  }
}
