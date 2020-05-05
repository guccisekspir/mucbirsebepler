import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_state.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/bloc/postbloc/bloc.dart';
import 'package:mucbirsebepler/model/post.dart';
import 'package:mucbirsebepler/model/user.dart';
import 'package:mucbirsebepler/widgets/uiHelperWidgets.dart';

class DiscoverPage extends StatefulWidget {
  final User user;

  const DiscoverPage({Key key, this.user}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  PostBloc _postBloc;
  DataBaseBloc _dataBaseBloc;
  User finalUser;

  @override
  void initState() {
    debugPrint(widget.user.profilURL);
    _postBloc = BlocProvider.of<PostBloc>(context);
    _postBloc.add(GetUser(userID: widget.user.userID));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIOverlays([]);
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Center(
            child: Icon(
              LineAwesomeIcons.plus,
              size: 40,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.deepOrange,
        ),
        body: Container(
          color: Colors.black,
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.0),
                  ),
                  child: Container(
                    color: Colors.deepPurpleAccent,
                    width: width,
                    height: height / 7,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Popüler Haberler",
                        style: GoogleFonts.pressStart2p(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60,),

                MultiBlocListener(
                  listeners: [
                    BlocListener<DataBaseBloc,DataBaseState>(
                      listener: (context,state){
                        if(state is DataBaseLoadedState){
                          finalUser= state.user;
                        }
                      },
                    ),

                    BlocListener<PostBloc,PostState>(
                      listener: (context,state){

                      },
                    )


                  ],
                )



              ],
            ),
          ),
        ),
      ),
    );
  }


}
