import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mucbirsebepler/bloc/authbloc/bloc.dart';



Widget backButton(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
            child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
          ),
          Text('Back',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
        ],
      ),
    ),
  );
}





Widget divider() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              color: Colors.deepPurpleAccent,
              thickness: 1,
            ),
          ),
        ),
        Text(
          'ya da',
          style: TextStyle(color: Colors.deepPurpleAccent),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              color: Colors.deepPurpleAccent,
              thickness: 1,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    ),
  );
}

Widget lineDivider(){

  return Container(
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
  );
}


Widget facebookButton(AuthBloc authBloc) {
  return Container(
    height: 50,
    margin: EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  topLeft: Radius.circular(5)),
            ),
            alignment: Alignment.center,
            child: Text('G',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w400)),
          ),
        ),
        Expanded(
          flex: 5,
          child: GestureDetector(
            onTap: () {
              authBloc.add(GoogleSign());
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Google ile Giriş Yap',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ),
      ],
    ),
  );
}


Widget entryField({String title,TextEditingController textEditingController,FaIcon faIcon}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.righteous(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          maxLines: null,
          style: GoogleFonts.roboto(color: Colors.deepPurple),
            controller: textEditingController,
            cursorColor: Colors.deepPurpleAccent,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(

                suffixIcon:faIcon,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fillColor: Colors.black,
                filled: true))
      ],
    ),
  );
}