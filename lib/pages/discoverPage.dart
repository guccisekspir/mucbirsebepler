import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_state.dart';
import 'package:mucbirsebepler/bloc/postbloc/bloc.dart';
import 'package:mucbirsebepler/model/post.dart';
import 'package:mucbirsebepler/model/user.dart';
import 'package:mucbirsebepler/widgets/uiHelperWidgets.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';

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
  Widget waitingWidget = SizedBox(
    height: 0,
    width: 0,
  );

  @override
  void initState() {
    debugPrint(widget.user.profilURL);
    _postBloc = BlocProvider.of<PostBloc>(context);
    _dataBaseBloc = BlocProvider.of<DataBaseBloc>(context);
    _dataBaseBloc.add(GetUserr(userID: widget.user.userID));

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScrollController _scrollController = ScrollController();
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
                SizedBox(
                  height: 10,
                ),
                MultiBlocListener(
                  listeners: [
                    BlocListener<DataBaseBloc, DataBaseState>(
                      listener: (context, state) {
                        if (state is DataBaseLoadedState) {
                          finalUser = state.user;
                          _postBloc.add(GetPost());
                        }
                      },
                    ),
                    BlocListener<PostBloc, PostState>(
                      listener: (context, state) {
                        if (state is PostLoadingState) {
                          waitingWidget = LoadingBouncingGrid.square(
                            borderColor: Colors.deepPurple,
                            backgroundColor: Colors.deepPurple,
                          );
                        }
                        if (state is PostErrorState) {
                          waitingWidget = SizedBox(
                            width: 0,
                            height: 0,
                          );
                          final snackBar = SnackBar(
                            content:
                                Text("İnternet bağlantınızı kontrol ediniz"),
                            backgroundColor: Colors.red,
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                        if (state is PostLoadedState) {
                          waitingWidget = SizedBox(
                            height: 0,
                            width: 0,
                          );
                        }
                      },
                    )
                  ],

                  child: BlocBuilder<PostBloc, PostState>(
                      // ignore: missing_return
                      builder: (context, state) {
                    if (state is PostLoadingState) {
                      return waitingWidget;
                    }
                    if (state is PostLoadedState) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: state.listPost.length,
                            shrinkWrap: true,
                            itemBuilder: (contex, index) {
                              return postContainer(
                                  post: state.listPost[index],
                                  width: width,
                                  height: height);
                            }),
                      );
                    }
                    if (state is InitialPostState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is PostErrorState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
