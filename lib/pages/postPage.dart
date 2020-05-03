import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mucbirsebepler/bloc/authbloc/bloc.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/bloc/postbloc/bloc.dart';
import 'package:mucbirsebepler/widgets/uiHelperWidgets.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostBloc _postBloc;
  TextEditingController headerController;
  TextEditingController descController;
  TextEditingController youtubeController;
  TextEditingController otherController;

  @override
  void initState() {
    _postBloc = BlocProvider.of<PostBloc>(context);
    headerController = TextEditingController(text: "");
    descController = TextEditingController(text: "");
    youtubeController = TextEditingController(text: "");
    otherController = TextEditingController(text: "");

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Mücbir Haber Paylaş",
          style: GoogleFonts.pressStart2p(
              fontSize: 15,
              color: Colors.black,
              wordSpacing: 1,
              letterSpacing: 0,
              fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: FaIcon(
          FontAwesomeIcons.solidShareSquare,
          color: Colors.deepOrange,
        ),
        elevation: 20,
        isExtended: true,
        onPressed: () {
          //TODO Formla yapılcak
        },
      ),
      body: BlocListener(
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
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: entryField(
                          title: "Haber Başlığı",
                          textEditingController: headerController,
                          faIcon: FaIcon(
                            FontAwesomeIcons.horseHead,
                            color: Colors.deepPurpleAccent,
                            size: 30,
                          )),
                    ),
                    lineDivider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: entryField(
                          title: "Haber İçeriği",
                          textEditingController: descController,
                          faIcon: FaIcon(
                            FontAwesomeIcons.userNinja,
                            color: Colors.deepPurpleAccent,
                            size: 30,
                          )),
                    ),
                    lineDivider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: entryField(
                          title: "Youtube Linki",
                          textEditingController: youtubeController,
                          faIcon: FaIcon(
                            FontAwesomeIcons.youtube,
                            color: Colors.deepPurpleAccent,
                            size: 30,
                          )),
                    ),
                    lineDivider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: entryField(
                          title: "Diğer Linkler",
                          textEditingController: otherController,
                          faIcon: FaIcon(
                            FontAwesomeIcons.slack,
                            color: Colors.deepPurpleAccent,
                            size: 30,
                          )),
                    ),
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
