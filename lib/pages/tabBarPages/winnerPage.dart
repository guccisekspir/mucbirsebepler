import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/model/user.dart';

class WinnerPage extends StatefulWidget {
  @override
  _WinnerPageState createState() => _WinnerPageState();
}

class _WinnerPageState extends State<WinnerPage> {
  DataBaseBloc _dataBaseBloc;

  @override
  void initState() {
    // TODO: implement initState
    _dataBaseBloc = BlocProvider.of<DataBaseBloc>(context);
    _dataBaseBloc.add(GetWinnerUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: BlocListener(
          bloc: _dataBaseBloc,
          listener: (context, state) {},
          child: BlocBuilder(
            bloc: _dataBaseBloc,
            // ignore: missing_return
            builder: (context, state) {
              if (state is DataBaseLoadingState) {
                return Center(
                  child: LoadingBouncingGrid.square(
                    borderColor: Colors.deepOrangeAccent,
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                );
              }
              if (state is DataBaseErrorState) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Bir hata oluştu"),
                  backgroundColor: Colors.red,
                ));
              }
              if (state is DataBaseLoadedState) {
                List<User> winnerUsers = state.winnerUsers;
                Color renk1=Colors.grey;
                return ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      if(index==0)renk1=Colors.orangeAccent;
                      if(index==1) renk1=Colors.redAccent;
                      if(index==2)renk1=Colors.greenAccent;
                      if(index-2>0) renk1=Colors.grey;
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: renk1,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blueGrey,
                            child: Text(
                              (index+1).toString(),
                              style: GoogleFonts.luckiestGuy(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),
                            ),
                          ),
                        ),
                        title: Text(winnerUsers[index].userName,style: GoogleFonts.righteous(color: Colors.cyanAccent),),
                        trailing: Icon(Icons.keyboard_arrow_right,color: Colors.cyanAccent,),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(color: Colors.limeAccent,),
                    itemCount: winnerUsers.length);
              }
            },
          ),
        ),
      ),
    );
  }
}
