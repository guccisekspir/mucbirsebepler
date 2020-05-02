import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Icon(
            LineAwesomeIcons.plus_circle,
            size: 40,
            color: Colors.black,
          ),
          backgroundColor: Colors.deepOrange,
        ),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text("Hoşgeldiniz"),
          leading: Image.asset(
            "assets/edis.png",
            fit: BoxFit.fill,
          ),
        ),
        body: Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 22,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("En Popüler Haberler",
                        style: GoogleFonts.righteous(
                            textStyle: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 30,
                        ))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 1),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1),
                          child: Divider(
                            color: Colors.deepPurpleAccent,
                            thickness: 1,
                          ),
                        ),
                      ),
                      Text(
                        "...",
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1),
                          child: Divider(
                            color: Colors.deepPurpleAccent,
                            thickness: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
