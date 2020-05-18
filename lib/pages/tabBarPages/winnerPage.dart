import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';




class WinnerPage extends StatefulWidget {
  @override
  _WinnerPageState createState() => _WinnerPageState();
}

class _WinnerPageState extends State<WinnerPage> {
  DataBaseBloc _dataBaseBloc;

  @override
  void initState() {
    // TODO: implement initState
    _dataBaseBloc=BlocProvider.of<DataBaseBloc>(context);
    _dataBaseBloc.add(GetWinnerUsers());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
