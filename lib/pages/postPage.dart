import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mucbirsebepler/bloc/authbloc/bloc.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/bloc/postbloc/bloc.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostBloc _postBloc;

  @override
  void initState() {
    _postBloc = BlocProvider.of<PostBloc>(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      child: BlocListener(
        bloc: _postBloc,
        listener: (context, PostState state) {},
        child: BlocBuilder(
          bloc: _postBloc,
          builder: (context, PostState state) {
            return Container(
              color: Colors.deepOrangeAccent,
              width: screenWidth,
              height: screenHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.deepPurpleAccent,
                      width: screenWidth,
                      height: screenHeight / 12,
                      child: Center(
                        child: Text(
                          "Mücbir Haber Paylaş",
                          style: GoogleFonts.pressStart2p(
                              fontSize: 15,
                              wordSpacing: 1,
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
