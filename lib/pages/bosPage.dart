import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';



class BosPagee extends StatefulWidget {
  @override
  _BosPageeState createState() => _BosPageeState();
}

class _BosPageeState extends State<BosPagee> {
  TextEditingController _textEditingController;
  DataBaseBloc _dataBaseBloc;
  @override
  void initState() {
    // TODO: implement initState
    _textEditingController=TextEditingController(text: "");
    _dataBaseBloc=BlocProvider.of<DataBaseBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            SizedBox(height: 250,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: TextField(
                  maxLength: 100,
                  cursorColor: Colors.limeAccent,
                  style: GoogleFonts.righteous(color: Colors.limeAccent),
                  decoration: InputDecoration(
                      errorStyle: GoogleFonts.righteous(color: Colors.redAccent),
                      labelStyle: GoogleFonts.righteous(color: Colors.limeAccent),
                      counterStyle:
                      GoogleFonts.righteous(color: Colors.limeAccent),
                      fillColor: Colors.limeAccent,
                      focusColor: Colors.limeAccent,
                      hoverColor: Colors.limeAccent,
                      labelText: "Yeni Kullanıcı Adı",
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.limeAccent)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.limeAccent)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.limeAccent)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.limeAccent))),
                  controller: _textEditingController,
                ),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Center(
              child: RaisedButton(
                child: Text("Değişiklikleri Kaydet",style: GoogleFonts.righteous(fontWeight: FontWeight.bold),),
                shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.limeAccent,width: 4.0)
                ),
                color: Colors.lime,
                highlightColor: Colors.deepPurpleAccent,
                elevation: 15,
                onPressed: () {
                  _dataBaseBloc.add(BosPage(_textEditingController.text));

                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


